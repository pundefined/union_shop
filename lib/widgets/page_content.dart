import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_footer.dart';

/// A helper widget that provides consistent page structure with scrolling
/// and an automatically appended footer.
///
/// Pages should use this widget to wrap their content instead of manually
/// adding scroll views and footers. This keeps the codebase DRY while
/// giving each page control over its own scroll behavior.
class PageContent extends StatelessWidget {
  /// The widgets to display in the scrollable area, before the footer.
  final List<Widget> children;

  /// Whether to include the footer at the bottom of the scroll area.
  /// Defaults to true.
  final bool showFooter;

  /// Optional padding to apply around the children (not the footer).
  final EdgeInsetsGeometry? padding;

  const PageContent({
    super.key,
    required this.children,
    this.showFooter = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (padding != null)
            Padding(
              padding: padding!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            )
          else
            ...children,
          if (showFooter) const AppFooter(),
        ],
      ),
    );
  }
}
