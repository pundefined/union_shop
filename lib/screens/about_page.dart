import 'package:flutter/material.dart';

/// A simple, accessible "About us" page used by the app's route table.
///
/// This widget intentionally does not include a `Scaffold` so it can be
/// composed as the `child` of a shared `AppShell` widget. It renders a
/// centered, constrained column of text with vertical scrolling when needed.
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Keep content easily readable on wide screens.
    const double maxContentWidth = 800.0;

    final paragraphs = <String>[
      'Welcome to the Union Shop!',
      'We’re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!',
      'All online purchases are available for delivery or instore collection!',
      'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don’t hesitate to contact us at hello@example.com.',
      'Happy shopping!',
    ];

    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.headlineSmall ??
        textTheme.titleLarge ??
        const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600);
    final bodyStyle = textTheme.bodyMedium ?? const TextStyle(fontSize: 14.0);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxContentWidth),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Semantic header for screen readers.
              Semantics(
                header: true,
                child: Text(
                  'About us',
                  style: titleStyle,
                ),
              ),
              const SizedBox(height: 16.0),

              // Body paragraphs
              for (final p in paragraphs) ...[
                Text(
                  p,
                  style: bodyStyle,
                ),
                const SizedBox(height: 12.0),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
