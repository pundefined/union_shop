import 'package:flutter/material.dart';

/// Sample collection data model
class Collection {
  final String title;
  final String imageUrl;

  const Collection({
    required this.title,
    required this.imageUrl,
  });
}

/// CollectionsPage displays a responsive grid of product collections.
/// Collections are shown as image tiles with overlaid text, allowing users
/// to browse curated product categories.
class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  /// Sample collections data with 8 curated product groups.
  static const List<Collection> sampleCollections = [
    Collection(
      title: 'Summer Sale',
      imageUrl:
          'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=500&h=500&fit=crop',
    ),
    Collection(
      title: 'New Arrivals',
      imageUrl:
          'https://images.unsplash.com/photo-1505695511574-73f5e69a7b2e?w=500&h=500&fit=crop',
    ),
    Collection(
      title: 'Clearance',
      imageUrl:
          'https://images.unsplash.com/photo-1552062407-291ce3f93c4f?w=500&h=500&fit=crop',
    ),
    Collection(
      title: 'Must Haves',
      imageUrl:
          'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=500&h=500&fit=crop',
    ),
    Collection(
      title: 'Premium Collection',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&h=500&fit=crop',
    ),
    Collection(
      title: 'Essentials',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop',
    ),
    Collection(
      title: 'Limited Edition',
      imageUrl:
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500&h=500&fit=crop',
    ),
    Collection(
      title: 'Gift Ideas',
      imageUrl:
          'https://images.unsplash.com/photo-1513225357062-080301f385cf?w=500&h=500&fit=crop',
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

/// CollectionTile displays a single collection with image background,
/// overlay text, and tap feedback via Material InkWell.
class CollectionTile extends StatelessWidget {
  final Collection collection;
  final VoidCallback onTap;

  const CollectionTile({
    super.key,
    required this.collection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image with fade-in effect
            FadeInImage.assetNetwork(
              placeholder: 'assets/placeholder.png',
              image: collection.imageUrl,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                );
              },
              placeholderErrorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                );
              },
            ),
            // Dark gradient overlay for text contrast
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Text overlay (title)
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Text(
                collection.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
