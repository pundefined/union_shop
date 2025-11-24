import 'package:flutter/material.dart';
import 'package:union_shop/styles/text_styles.dart';

/// CollectionTile represents a collection item with title and image URL.
/// This is used in the collections grid browsing experience.
class CollectionTileData {
  final String title;
  final String imageUrl;

  const CollectionTileData({
    required this.title,
    required this.imageUrl,
  });
}

/// CollectionTile widget displays a single collection with image background,
/// overlay text, and tap feedback via Material InkWell.
class CollectionTile extends StatelessWidget {
  final CollectionTileData collection;
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
                style: TextStyles.collectionTileTitle,
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
