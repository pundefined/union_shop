import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/widgets/collection_tile.dart';

/// CollectionsPage displays a responsive grid of product collections.
/// Collections are shown as image tiles with overlaid text, allowing users
/// to browse curated product categories.
class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  /// Sample collections data with 8 curated product groups.
  static final List<Collection> sampleCollections = [
    Collection(
      id: 'summer',
      title: 'Summer Sale',
      description: 'Beat the heat with our summer collection',
      imageUrl:
          'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=500&h=500&fit=crop',
      items: [],
    ),
    Collection(
      id: 'arrivals',
      title: 'New Arrivals',
      description: 'Discover what\'s new this season',
      imageUrl:
          'https://images.unsplash.com/photo-1505695511574-73f5e69a7b2e?w=500&h=500&fit=crop',
      items: [],
    ),
    Collection(
      id: 'clearance',
      title: 'Clearance',
      description: 'Great deals on selected items',
      imageUrl:
          'https://images.unsplash.com/photo-1552062407-291ce3f93c4f?w=500&h=500&fit=crop',
      items: [],
    ),
    Collection(
      id: 'musthaves',
      title: 'Must Haves',
      description: 'Customer favorites and bestsellers',
      imageUrl:
          'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=500&h=500&fit=crop',
      items: [],
    ),
    Collection(
      id: 'premium',
      title: 'Premium Collection',
      description: 'Luxury items for the discerning shopper',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&h=500&fit=crop',
      items: [],
    ),
    Collection(
      id: 'essentials',
      title: 'Essentials',
      description: 'The basics you always need',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop',
      items: [],
    ),
    Collection(
      id: 'limited',
      title: 'Limited Edition',
      description: 'Exclusive items available for a limited time',
      imageUrl:
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500&h=500&fit=crop',
      items: [],
    ),
    Collection(
      id: 'gifts',
      title: 'Gift Ideas',
      description: 'Perfect presents for every occasion',
      imageUrl:
          'https://images.unsplash.com/photo-1513225357062-080301f385cf?w=500&h=500&fit=crop',
      items: [],
    ),
  ];

  /// Calculate responsive column count based on screen width.
  /// - 2 columns for screen width < 600px (mobile)
  /// - 3 columns for screen width 600–900px (tablet)
  /// - 4 columns for screen width > 900px (desktop)
  static int getColumnCount(double width) {
    if (width < 600) {
      return 2;
    } else if (width < 900) {
      return 3;
    } else {
      return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnCount = getColumnCount(constraints.maxWidth);

        return GridView.builder(
          padding: const EdgeInsets.all(12.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.0, // Square tiles
          ),
          itemCount: sampleCollections.length,
          itemBuilder: (context, index) {
            return CollectionTile(
              collection: sampleCollections[index],
              onTap: () {
                // Placeholder for future navigation logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tapped: ${sampleCollections[index].title}'),
                    duration: const Duration(milliseconds: 800),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
