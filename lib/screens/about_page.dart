import 'package:flutter/material.dart';
import 'package:union_shop/styles/text_styles.dart';

/// The about page content widget.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Keep content easily readable on wide screens.
    const double maxContentWidth = 800.0;

    final paragraphs = <String>[
      'Welcome to the Union Shop!',
      'We\'re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!',
      'All online purchases are available for delivery or instore collection!',
      'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us at hello@example.com.',
      'Happy shopping!',
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Semantic header for screen readers.
              Semantics(
                header: true,
                child: const Text(
                  'About us',
                  style: TextStyles.aboutPageHeading,
                ),
              ),
              const SizedBox(height: 16.0),

              // Body paragraphs
              for (final p in paragraphs) ...[
                Text(
                  p,
                  style: TextStyles.bodyText,
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
