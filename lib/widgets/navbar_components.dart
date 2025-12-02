import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/auth_provider.dart';
import 'package:union_shop/styles/text_styles.dart';

/// Reusable navigation link widget with consistent styling and accessibility.
/// Displays a navigation link as an expanded centered button with semantic labels.
class NavLink extends StatelessWidget {
  final String label;
  final String text;
  final VoidCallback onPressed;

  const NavLink({
    super.key,
    required this.label,
    required this.text,
    required this.onPressed,
  });

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

/// Right-side navigation icons (search, account, cart, hamburger menu).
/// Handles auth-aware account button behavior.
class NavbarIcons extends StatelessWidget {
  final VoidCallback? onSearch;
  final VoidCallback? onAccount;
  final VoidCallback? onCart;
  final VoidCallback? onMenuToggle;
  final bool showMenuButton;

  const NavbarIcons({
    super.key,
    this.onSearch,
    this.onAccount,
    this.onCart,
    this.onMenuToggle,
    this.showMenuButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search button
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
            onPressed: onSearch,
          ),
          // Auth-aware account button
          _AccountButton(onAccount: onAccount),
          // Cart button
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
            onPressed: onCart ?? () => context.go('/cart'),
          ),
          // Hamburger menu icon shown only on mobile
          if (showMenuButton)
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
              onPressed: onMenuToggle,
            ),
        ],
      ),
    );
  }
}

/// Auth-aware account button that shows different UI based on authentication state.
class _AccountButton extends StatelessWidget {
  final VoidCallback? onAccount;

  const _AccountButton({this.onAccount});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final isAuthenticated = authProvider.isAuthenticated;

        if (isAuthenticated) {
          // Show popup menu for authenticated users
          return PopupMenuButton<String>(
            icon: Icon(
              Icons.person,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
            tooltip: 'Account',
            constraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            onSelected: (value) async {
              if (value == 'signout') {
                context.go('/');
                await authProvider.signOut();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                enabled: false,
                child: Text(
                  authProvider.userEmail ?? 'Account',
                  style: TextStyles.caption,
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'signout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 18),
                    SizedBox(width: 8),
                    Text('Sign Out'),
                  ],
                ),
              ),
            ],
          );
        }

        // Show login button for unauthenticated users
        return IconButton(
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
          tooltip: 'Login',
          onPressed: onAccount ?? () => context.go('/login'),
        );
      },
    );
  }
}
