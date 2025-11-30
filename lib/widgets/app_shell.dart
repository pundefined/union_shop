import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/widgets/app_navbar.dart';

/// AppShell provides the complete page structure: Scaffold, navbar, scrolling,
/// and footer. All pages should be wrapped in AppShell in main.dart for
/// consistent behavior.
class AppShell extends StatelessWidget {
  /// The page content widget to display in the scrollable area.
  /// Will be placed between the navbar and footer.
  final Widget child;

  /// Whether to include the navbar at the top of the scroll area.
  /// Defaults to true.
  final bool showNavbar;

  /// Whether to include the footer at the bottom of the scroll area.
  /// Defaults to true.
  final bool showFooter;

  /// Optional padding to apply around the content (not the navbar or footer).
  final EdgeInsetsGeometry? padding;

  /// Optional floating action button for the Scaffold.
  final Widget? floatingActionButton;

  /// Optional bottom navigation bar for the Scaffold.
  final Widget? bottomNavigationBar;

  const AppShell({
    super.key,
    required this.child,
    this.showNavbar = true,
    this.showFooter = true,
    this.padding,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showNavbar) const AppNavbar(),
            if (padding != null)
              Padding(padding: padding!, child: child)
            else
              child,
            if (showFooter) const AppFooter(),
          ],
        ),
      ),
    );
  }
}
