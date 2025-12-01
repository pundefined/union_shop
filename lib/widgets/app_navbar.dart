import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/styles/text_styles.dart';
import 'package:union_shop/widgets/search_overlay.dart';

/// Responsive breakpoint constants for adaptive navigation layout.
const double _mobileBreakpoint = 600.0;

/// Enumeration for screen size categories.
enum ScreenSize { mobile, desktop }

/// A reusable top navigation bar used across the app with responsive design.
/// On mobile screens, displays a hamburger menu; on desktop, displays horizontal links.
class AppNavbar extends StatefulWidget {
  final VoidCallback? onLogoTap;
  final VoidCallback? onSearch;
  final VoidCallback? onAccount;
  final VoidCallback? onCart;

  const AppNavbar({
    Key? key,
    this.onLogoTap,
    this.onSearch,
    this.onAccount,
    this.onCart,
  }) : super(key: key);

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  /// Tracks whether the mobile menu is open or closed.
  bool _isMenuOpen = false;

  /// Tracks whether the search overlay is open or closed.
  bool _isSearchOpen = false;

  /// Determines the screen size category based on media query width.
  ScreenSize _getScreenSize(double width) {
    if (width < _mobileBreakpoint) {
      return ScreenSize.mobile;
    } else {
      return ScreenSize.desktop;
    }
  }

  /// Toggles the mobile menu open/closed state.
  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  /// Toggles the search overlay open/closed state.
  void _toggleSearch() {
    setState(() {
      _isSearchOpen = !_isSearchOpen;
    });
  }

  void _navigateHome(BuildContext context) {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenSize = _getScreenSize(screenWidth);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyles.bannerText,
            ),
          ),

          // Main header row - show search overlay or normal header
          SizedBox(
            height: 56,
            child: _isSearchOpen
                ? SearchOverlay(onClose: _toggleSearch)
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo with semantic label and minimum tappable area
                        Semantics(
                          label: 'Home',
                          button: true,
                          child: InkWell(
                            onTap: widget.onLogoTap ??
                                () => _navigateHome(context),
                            child: const SizedBox(
                              height: 48,
                              child: Center(
                                child: ImageNetworkLogo(),
                              ),
                            ),
                          ),
                        ),

                        // Show/hide nav links based on screen size
                        if (screenSize != ScreenSize.mobile)
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                NavLink(
                                  label: 'Home',
                                  text: 'Home',
                                  onPressed: () => context.go('/'),
                                ),
                                NavLink(
                                  label: 'Sale',
                                  text: 'Sale',
                                  onPressed: () {
                                    final saleCollection =
                                        sampleCollections.firstWhere(
                                            (c) => c.id == 'summer-sale');
                                    context.go(
                                        '/collections/${saleCollection.slug}');
                                  },
                                ),
                                NavLink(
                                  label: 'About',
                                  text: 'About',
                                  onPressed: () => context.go('/about'),
                                ),
                                NavLink(
                                  label: 'Collections',
                                  text: 'Collections',
                                  onPressed: () => context.go('/collections'),
                                ),
                                // Shop dropdown for desktop - links to each collection
                                const ShopDropdown(),
                                // Print Shack dropdown for desktop
                                const PrintShackDropdown(),
                              ],
                            ),
                          ),

                        // Right-side icons constrained in width
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 48,
                                  minHeight: 48,
                                ),
                                onPressed: widget.onSearch ?? _toggleSearch,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.person_outline,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 48,
                                  minHeight: 48,
                                ),
                                onPressed: widget.onAccount ??
                                    () => context.go('/login'),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 48,
                                  minHeight: 48,
                                ),
                                onPressed:
                                    widget.onCart ?? () => context.go('/cart'),
                              ),
                              // Hamburger menu icon shown only on mobile
                              if (screenSize == ScreenSize.mobile)
                                IconButton(
                                  icon: const Icon(
                                    Icons.menu,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 48,
                                    minHeight: 48,
                                  ),
                                  onPressed: _toggleMenu,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),

          // Mobile menu - shown only on mobile screens when menu is open
          if (screenSize == ScreenSize.mobile && _isMenuOpen)
            MobileMenuContainer(
              onHomeTap: () {
                context.go('/');
                _toggleMenu();
              },
              onSaleTap: () {
                final saleCollection =
                    sampleCollections.firstWhere((c) => c.id == 'summer-sale');
                context.go('/collections/${saleCollection.slug}');
                _toggleMenu();
              },
              onAboutTap: () {
                context.go('/about');
                _toggleMenu();
              },
              onCollectionsTap: () {
                context.go('/collections');
                _toggleMenu();
              },
              onShopCollectionTap: (slug) {
                context.go('/collections/$slug');
                _toggleMenu();
              },
              onPrintShackPersonaliseTap: () {
                context.go('/print-shack');
                _toggleMenu();
              },
              onPrintShackAboutTap: () {
                context.go('/print-shack/about');
                _toggleMenu();
              },
            ),
        ],
      ),
    );
  }
}

/// Reusable navigation link widget with consistent styling and accessibility.
/// Displays a navigation link as an expanded centered button with semantic labels.
class NavLink extends StatelessWidget {
  final String label;
  final String text;
  final VoidCallback onPressed;

  const NavLink({
    Key? key,
    required this.label,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Semantics(
          label: label,
          button: true,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              minimumSize: const Size(48, 48),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              foregroundColor: Colors.black,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}

/// Small stateless widget to keep the image construction const-friendly
/// while preserving the same NetworkImage + errorBuilder behavior.
class ImageNetworkLogo extends StatelessWidget {
  const ImageNetworkLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
      height: 18,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          width: 18,
          height: 18,
          child: const Center(
            child: Icon(Icons.image_not_supported, color: Colors.grey),
          ),
        );
      },
    );
  }
}

/// Mobile menu container that displays navigation links vertically.
/// Designed to slide down below the navbar on mobile screens.
class MobileMenuContainer extends StatefulWidget {
  /// Callback when a menu item is tapped
  final VoidCallback? onHomeTap;
  final VoidCallback? onSaleTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onCollectionsTap;
  final VoidCallback? onPrintShackPersonaliseTap;
  final VoidCallback? onPrintShackAboutTap;
  final void Function(String slug)? onShopCollectionTap;

  const MobileMenuContainer({
    Key? key,
    this.onHomeTap,
    this.onSaleTap,
    this.onAboutTap,
    this.onCollectionsTap,
    this.onPrintShackPersonaliseTap,
    this.onPrintShackAboutTap,
    this.onShopCollectionTap,
  }) : super(key: key);

  @override
  State<MobileMenuContainer> createState() => _MobileMenuContainerState();
}

class _MobileMenuContainerState extends State<MobileMenuContainer> {
  bool _isPrintShackExpanded = false;
  bool _isShopExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Border at the bottom for visual separation
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mobile menu item for Home
          _MobileMenuItem(
            icon: Icons.home,
            label: 'Home',
            onTap: widget.onHomeTap,
          ),
          // Mobile menu item for Sale
          _MobileMenuItem(
            icon: Icons.local_offer,
            label: 'Sale',
            onTap: widget.onSaleTap,
          ),
          // Mobile menu item for About
          _MobileMenuItem(
            icon: Icons.info,
            label: 'About',
            onTap: widget.onAboutTap,
          ),
          // Mobile menu item for Collections
          _MobileMenuItem(
            icon: Icons.grid_view,
            label: 'Collections',
            onTap: widget.onCollectionsTap,
          ),
          // Expandable Shop section
          _MobileMenuExpandableItem(
            icon: Icons.shopping_bag,
            label: 'Shop',
            isExpanded: _isShopExpanded,
            onTap: () {
              setState(() {
                _isShopExpanded = !_isShopExpanded;
              });
            },
          ),
          if (_isShopExpanded) ...[
            for (final collection in sampleCollections)
              _MobileMenuSubItem(
                label: collection.title,
                onTap: () => widget.onShopCollectionTap?.call(collection.slug),
              ),
          ],
          // Expandable Print Shack section
          _MobileMenuExpandableItem(
            icon: Icons.edit,
            label: 'The Print Shack',
            isExpanded: _isPrintShackExpanded,
            onTap: () {
              setState(() {
                _isPrintShackExpanded = !_isPrintShackExpanded;
              });
            },
          ),
          if (_isPrintShackExpanded) ...[
            _MobileMenuSubItem(
              label: 'Personalise',
              onTap: widget.onPrintShackPersonaliseTap,
            ),
            _MobileMenuSubItem(
              label: 'About',
              onTap: widget.onPrintShackAboutTap,
            ),
          ],
        ],
      ),
    );
  }
}

/// Individual menu item widget for mobile menu.
/// Displays an icon, label, and tap feedback.
class _MobileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _MobileMenuItem({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          // Padding for comfortable touch target and spacing
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Icon for visual identification
              Icon(
                icon,
                size: 20,
                color: Colors.grey[700],
              ),
              // Space between icon and label
              const SizedBox(width: 16),
              // Menu item label text
              Semantics(
                label: label,
                button: true,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Expandable menu item for mobile menu with expand/collapse arrow.
class _MobileMenuExpandableItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isExpanded;
  final VoidCallback? onTap;

  const _MobileMenuExpandableItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isExpanded,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Semantics(
                  label: label,
                  button: true,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 20,
                color: Colors.grey[700],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sub-item for expandable mobile menu sections.
class _MobileMenuSubItem extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _MobileMenuSubItem({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          // Indent sub-items
          margin: const EdgeInsets.only(left: 36),
          child: Row(
            children: [
              Semantics(
                label: label,
                button: true,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Desktop dropdown menu for The Print Shack section.
/// Shows a dropdown with sub-items on click.
class PrintShackDropdown extends StatelessWidget {
  const PrintShackDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      tooltip: 'The Print Shack',
      popUpAnimationStyle: AnimationStyle.noAnimation,
      onSelected: (value) {
        if (value == 'personalise') {
          context.go('/print-shack');
        } else if (value == 'about') {
          context.go('/print-shack/about');
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'personalise',
          child: Text('Personalise'),
        ),
        const PopupMenuItem<String>(
          value: 'about',
          child: Text('About'),
        ),
      ],
      child: Semantics(
        label: 'The Print Shack',
        button: true,
        child: Container(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Print Shack',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

/// Desktop dropdown menu for Shop section.
/// Shows a dropdown with links to each collection.
class ShopDropdown extends StatelessWidget {
  const ShopDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      tooltip: 'Shop',
      popUpAnimationStyle: AnimationStyle.noAnimation,
      onSelected: (value) {
        context.go('/collections/$value');
      },
      itemBuilder: (context) => sampleCollections
          .map(
            (collection) => PopupMenuItem<String>(
              value: collection.slug,
              child: Text(collection.title),
            ),
          )
          .toList(),
      child: Semantics(
        label: 'Shop',
        button: true,
        child: Container(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Shop',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
