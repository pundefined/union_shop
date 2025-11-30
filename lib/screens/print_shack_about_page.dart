import 'package:flutter/material.dart';
import '../styles/text_styles.dart';
import '../widgets/page_content.dart';

/// PrintShackAboutPage displays information about the personalisation service,
/// including service description, guidelines, and pricing info.
class PrintShackAboutPage extends StatelessWidget {
  const PrintShackAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContent(
      children: [
        // Page content
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page heading
              const Text(
                'The Print Shack',
                style: TextStyles.productHeading,
              ),

              const SizedBox(height: 24),

              // Service description
              const Text(
                'About Our Service',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 8),
              const Text(
                'The Print Shack is our exclusive personalisation service, allowing you to add '
                'custom text to your favourite Union Shop merchandise. Whether it\'s your name, '
                'a special date, or a meaningful message, we can make your items truly unique.',
                style: TextStyles.bodyText,
              ),

              const SizedBox(height: 24),

              // Guidelines
              const Text(
                'Guidelines',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 8),
              const Text(
                '• Up to 4 lines of text available\n'
                '• Maximum 20 characters per line\n'
                '• Text is printed exactly as entered - please check spelling\n'
                '• Personalised items cannot be returned or exchanged\n'
                '• Allow 3-5 working days for personalised orders',
                style: TextStyles.bodyText,
              ),

              const SizedBox(height: 24),

              // Pricing
              const Text(
                'Pricing',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 8),
              const Text(
                '• 1 line: £3.00\n'
                '• 2 lines: £5.00\n'
                '• 3 lines: £7.00\n'
                '• 4 lines: £8.50',
                style: TextStyles.bodyText,
              ),

              const SizedBox(height: 24),

              // Call to action
              const Text(
                'Ready to personalise?',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 8),
              const Text(
                'Head over to our personalisation form to get started!',
                style: TextStyles.bodyText,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/print-shack');
                  },
                  child: const Text('Start Personalising'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
