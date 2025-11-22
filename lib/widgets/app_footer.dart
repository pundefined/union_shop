import 'package:flutter/material.dart';

/// Shared app footer used across pages.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle plainStyle = TextStyle(
      color: Colors.grey[800],
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    final TextStyle italicStyle =
        plainStyle.copyWith(fontStyle: FontStyle.italic);
    final TextStyle headingStyle =
        plainStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w700);
    final TextStyle linkStyle = plainStyle.copyWith(color: Colors.blue);

    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Opening Hours', style: headingStyle),
          const SizedBox(height: 8),
          Text('❄️ Winter Break Closure Dates ❄️', style: italicStyle),
          const SizedBox(height: 6),
          Text('Closing 4pm 19/12/2025', style: plainStyle),
          Text('Reopening 10am 05/01/2026', style: plainStyle),
          Text('Last post date: 12pm on 18/12/2025', style: plainStyle),
          const SizedBox(height: 8),
          Text('-------------------------', style: plainStyle),
          const SizedBox(height: 8),
          Text('(Term Time)', style: italicStyle),
          Text('Monday - Friday 10am - 4pm', style: plainStyle),
          const SizedBox(height: 8),
          Text('(Outside of Term Time / Consolidation Weeks)',
              style: italicStyle),
          Text('Monday - Friday 10am - 3pm', style: plainStyle),
          const SizedBox(height: 8),
          Text('Purchase online 24/7', style: plainStyle),
          const SizedBox(height: 20),
          Text('Help and Information', style: headingStyle),
          const SizedBox(height: 12),
          // Clickable items (no links yet) — use same font settings but blue color for visual affordance.
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text('Search', style: linkStyle),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child:
                  Text('Terms & Conditions of Sale Policy', style: linkStyle),
            ),
          ),
        ],
      ),
    );
  }
}
