import 'package:flutter/material.dart';
import 'package:union_shop/styles/text_styles.dart';

/// Shared app footer used across pages.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Opening Hours', style: TextStyles.footerHeading),
          const SizedBox(height: 8),
          Text('❄️ Winter Break Closure Dates ❄️',
              style: TextStyles.footerItalic),
          const SizedBox(height: 6),
          Text('Closing 4pm 19/12/2025', style: TextStyles.footerPlain),
          Text('Reopening 10am 05/01/2026', style: TextStyles.footerPlain),
          Text('Last post date: 12pm on 18/12/2025',
              style: TextStyles.footerPlain),
          const SizedBox(height: 8),
          Text('-------------------------', style: TextStyles.footerPlain),
          const SizedBox(height: 8),
          Text('(Term Time)', style: TextStyles.footerItalic),
          Text('Monday - Friday 10am - 4pm', style: TextStyles.footerPlain),
          const SizedBox(height: 8),
          Text('(Outside of Term Time / Consolidation Weeks)',
              style: TextStyles.footerItalic),
          Text('Monday - Friday 10am - 3pm', style: TextStyles.footerPlain),
          const SizedBox(height: 8),
          Text('Purchase online 24/7', style: TextStyles.footerPlain),
          const SizedBox(height: 20),
          Text('Help and Information', style: TextStyles.footerHeading),
          const SizedBox(height: 12),
          // Clickable items (no links yet) — use same font settings but blue color for visual affordance.
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text('Search', style: TextStyles.footerLink),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text('Terms & Conditions of Sale Policy',
                  style: TextStyles.footerLink),
            ),
          ),
        ],
      ),
    );
  }
}
