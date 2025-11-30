import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_navbar.dart';

/// AppShell composes the shared AppNavbar with page content.
class AppShell extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? floatingAction;
  final Widget? bottomNav;
  final bool showNavbar;

  const AppShell({
    Key? key,
    required this.child,
    this.title,
    this.floatingAction,
    this.bottomNav,
    this.showNavbar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We place the shared navbar in the body so it can be composed with
      // arbitrary page content. Floating action and bottom nav are passed
      // through to the scaffold so pages can still display them.
      floatingActionButton: floatingAction,
      bottomNavigationBar: bottomNav,
      body: Column(
        children: [
          if (showNavbar) const AppNavbar(),
          if (title != null)
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          // Each page is responsible for its own scrolling behavior.
          // Pages should use PageContent widget for consistent scroll + footer,
          // or implement custom scroll logic as needed.
          Expanded(child: child),
        ],
      ),
    );
  }
}
