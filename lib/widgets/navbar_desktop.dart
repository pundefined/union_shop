import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/styles/text_styles.dart';
import 'package:union_shop/widgets/navbar_components.dart';

/// Desktop navigation links row.
/// Contains Home, Sale, About links plus Shop and Print Shack dropdowns.
class DesktopNavLinks extends StatelessWidget {
  const DesktopNavLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavLink(
            label: 'Home',
            text: 'Home',
            onPressed: () => context.go('/'),
          ),
          NavLink(
            label: 'Sale',
            text: 'Sale',
            onPressed: () {
              final saleCollection =
                  sampleCollections.firstWhere((c) => c.id == 'summer-sale');
              context.go('/collections/${saleCollection.slug}');
            },
          ),
          NavLink(
            label: 'About',
            text: 'About',
            onPressed: () => context.go('/about'),
          ),
          // Shop dropdown for desktop - links to each collection
          const ShopDropdown(),
          // Print Shack dropdown for desktop
          const PrintShackDropdown(),
        ],
      ),
    );
  }
}

/// Desktop dropdown menu for The Print Shack section.
/// Shows a dropdown with sub-items on click.
class PrintShackDropdown extends StatelessWidget {
  const PrintShackDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      tooltip: 'The Print Shack',
      popUpAnimationStyle: AnimationStyle.noAnimation,
      onSelected: (value) {
        if (value == 'personalise') {
          context.go('/print-shack');
        } else if (value == 'about') {
          context.go('/print-shack/about');
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'personalise',
          child: Text('Personalise'),
        ),
        const PopupMenuItem<String>(
          value: 'about',
          child: Text('About'),
        ),
      ],
      child: Semantics(
        label: 'The Print Shack',
        button: true,
        child: Container(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Print Shack',
                style: TextStyles.navLink,
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

/// Desktop dropdown menu for Shop section.
/// Shows a dropdown with links to each collection.
class ShopDropdown extends StatelessWidget {
  const ShopDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      tooltip: 'Shop',
      popUpAnimationStyle: AnimationStyle.noAnimation,
      onSelected: (value) {
        context.go('/collections/$value');
      },
      itemBuilder: (context) => sampleCollections
          .map(
            (collection) => PopupMenuItem<String>(
              value: collection.slug,
              child: Text(collection.title),
            ),
          )
          .toList(),
      child: Semantics(
        label: 'Shop',
        button: true,
        child: Container(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Shop',
                style: TextStyles.navLink,
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
