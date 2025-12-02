import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/auth_provider.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/styles/text_styles.dart';

/// Mobile menu container that displays navigation links vertically.
/// Designed to slide down below the navbar on mobile screens.
class MobileMenuContainer extends StatefulWidget {
  /// Callback when a menu item is tapped
  final VoidCallback? onHomeTap;
  final VoidCallback? onSaleTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onPrintShackPersonaliseTap;
  final VoidCallback? onPrintShackAboutTap;
  final void Function(String slug)? onShopCollectionTap;
  final VoidCallback? onLoginTap;
  final VoidCallback? onSignOutTap;

  const MobileMenuContainer({
    super.key,
    this.onHomeTap,
    this.onSaleTap,
    this.onAboutTap,
    this.onPrintShackPersonaliseTap,
    this.onPrintShackAboutTap,
    this.onShopCollectionTap,
    this.onLoginTap,
    this.onSignOutTap,
  });

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
          MobileMenuItem(
            icon: Icons.home,
            label: 'Home',
            onTap: widget.onHomeTap,
          ),
          // Mobile menu item for Sale
          MobileMenuItem(
            icon: Icons.local_offer,
            label: 'Sale',
            onTap: widget.onSaleTap,
          ),
          // Mobile menu item for About
          MobileMenuItem(
            icon: Icons.info,
            label: 'About',
            onTap: widget.onAboutTap,
          ),
          // Expandable Shop section
          MobileMenuExpandableItem(
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
              MobileMenuSubItem(
                label: collection.title,
                onTap: () => widget.onShopCollectionTap?.call(collection.slug),
              ),
          ],
          // Expandable Print Shack section
          MobileMenuExpandableItem(
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
            MobileMenuSubItem(
              label: 'Personalise',
              onTap: widget.onPrintShackPersonaliseTap,
            ),
            MobileMenuSubItem(
              label: 'About',
              onTap: widget.onPrintShackAboutTap,
            ),
          ],
          // Auth-aware menu item (Login or Sign Out)
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              if (authProvider.isAuthenticated) {
                return Column(
                  children: [
                    // Show user email as disabled item
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      width: double.infinity,
                      child: Text(
                        authProvider.userEmail ?? 'Account',
                        style: TextStyles.caption,
                      ),
                    ),
                    MobileMenuItem(
                      icon: Icons.logout,
                      label: 'Sign Out',
                      onTap: widget.onSignOutTap,
                    ),
                  ],
                );
              }
              return MobileMenuItem(
                icon: Icons.login,
                label: 'Login',
                onTap: widget.onLoginTap,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Individual menu item widget for mobile menu.
/// Displays an icon, label, and tap feedback.
class MobileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const MobileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

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
                  style: TextStyles.menuItem,
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
class MobileMenuExpandableItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isExpanded;
  final VoidCallback? onTap;

  const MobileMenuExpandableItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isExpanded,
    this.onTap,
  });

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
                    style: TextStyles.menuItem,
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
class MobileMenuSubItem extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const MobileMenuSubItem({
    super.key,
    required this.label,
    this.onTap,
  });

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
                  style: TextStyles.menuSubItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
