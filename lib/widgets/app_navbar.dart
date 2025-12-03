import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/auth_provider.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/styles/text_styles.dart';
import 'package:union_shop/utils/responsive.dart';
import 'package:union_shop/widgets/navbar_components.dart';
import 'package:union_shop/widgets/navbar_desktop.dart';
import 'package:union_shop/widgets/navbar_mobile.dart';
import 'package:union_shop/widgets/search_overlay.dart';

/// A reusable top navigation bar used across the app with responsive design.
/// On mobile screens, displays a hamburger menu; on desktop, displays horizontal links.
class AppNavbar extends StatefulWidget {
  final VoidCallback? onLogoTap;
  final VoidCallback? onSearch;
  final VoidCallback? onAccount;
  final VoidCallback? onCart;

  const AppNavbar({
    super.key,
    this.onLogoTap,
    this.onSearch,
    this.onAccount,
    this.onCart,
  });

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  /// Tracks whether the mobile menu is open or closed.
  bool _isMenuOpen = false;

  /// Tracks whether the search overlay is open or closed.
  bool _isSearchOpen = false;

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
    final screenSize = context.screenSize;
    final isMobile = screenSize == ScreenSize.mobile;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top banner
          _buildBanner(context),

          // Main header row - show search overlay or normal header
          SizedBox(
            height: 56,
            child: _isSearchOpen
                ? SearchOverlay(onClose: _toggleSearch)
                : _buildHeader(context, isMobile),
          ),

          // Mobile menu - shown only on mobile screens when menu is open
          if (isMobile && _isMenuOpen) _buildMobileMenu(context),
        ],
      ),
    );
  }

  /// Builds the top promotional banner.
  Widget _buildBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).colorScheme.primary,
      child: const Text(
        'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
        textAlign: TextAlign.center,
        style: TextStyles.bannerText,
      ),
    );
  }

  /// Builds the main header row with logo, nav links, and icons.
  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Container(
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
              child: SizedBox(
                height: 48,
                child: Center(
                  child: Image.asset(
                    'assets/images/union_logo.png',
                    height: 18,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Show/hide nav links based on screen size
          if (!isMobile) const DesktopNavLinks(),

          // Right-side icons
          NavbarIcons(
            onSearch: widget.onSearch ?? _toggleSearch,
            onAccount: widget.onAccount,
            onCart: widget.onCart,
            onMenuToggle: _toggleMenu,
            showMenuButton: isMobile,
          ),
        ],
      ),
    );
  }

  /// Builds the mobile menu with navigation callbacks.
  Widget _buildMobileMenu(BuildContext context) {
    return MobileMenuContainer(
      onHomeTap: () {
        context.go('/');
        _toggleMenu();
      },
      onSaleTap: () {
        final saleCollection =
            storeCollections.firstWhere((c) => c.id == 'summer-sale');
        context.go('/collections/${saleCollection.slug}');
        _toggleMenu();
      },
      onAboutTap: () {
        context.go('/about');
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
      onLoginTap: () {
        context.go('/login');
        _toggleMenu();
      },
      onSignOutTap: () async {
        final authProvider = context.read<AuthProvider>();
        // Navigate and close menu first, then sign out to avoid
        // context issues during rebuild
        context.go('/');
        _toggleMenu();
        await authProvider.signOut();
      },
    );
  }
}
