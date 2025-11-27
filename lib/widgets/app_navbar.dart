import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/styles/text_styles.dart';

/// Responsive breakpoint constants for adaptive navigation layout.
const double _mobileBreakpoint = 600.0;
const double _tabletBreakpoint = 900.0;

/// Enumeration for screen size categories.
enum ScreenSize { mobile, tablet, desktop }

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
  /// Determines the screen size category based on media query width.
  ScreenSize _getScreenSize(double width) {
    if (width < _mobileBreakpoint) {
      return ScreenSize.mobile;
    } else if (width < _tabletBreakpoint) {
      return ScreenSize.tablet;
    } else {
      return ScreenSize.desktop;
    }
  }

  void _navigateHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenSize = _getScreenSize(screenWidth);
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
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

          // Main header row
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo with semantic label and minimum tappable area
                  Semantics(
                    label: 'Home',
                    button: true,
                    child: InkWell(
                      onTap: widget.onLogoTap ?? () => _navigateHome(context),
                      child: const SizedBox(
                        height: 48,
                        child: Center(
                          child: ImageNetworkLogo(),
                        ),
                      ),
                    ),
                  ),

                  // Show/hide nav links based on screen size
                  if (screenSize != ScreenSize.mobile) ...[
                    NavLink(
                      label: 'Home',
                      text: 'Home',
                      onPressed: () => Navigator.pushNamed(context, '/'),
                    ),
                    NavLink(
                      label: 'Sale',
                      text: 'Sale',
                      onPressed: () {
                        final saleCollection =
                            sampleCollections.firstWhere((c) => c.id == 'sale');
                        Navigator.pushNamed(
                          context,
                          '/collection',
                          arguments: saleCollection,
                        );
                      },
                    ),
                    NavLink(
                      label: 'About',
                      text: 'About',
                      onPressed: () => Navigator.pushNamed(context, '/about'),
                    ),
                    NavLink(
                      label: 'Collections',
                      text: 'Collections',
                      onPressed: () =>
                          Navigator.pushNamed(context, '/collections'),
                    ),
                  ],

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
                          onPressed: widget.onSearch ?? () {},
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
                              () => Navigator.pushNamed(context, '/login'),
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
                          onPressed: widget.onCart ?? () {},
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
                            onPressed: () {
                              // TODO: Implement menu toggle in subtask 6
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
