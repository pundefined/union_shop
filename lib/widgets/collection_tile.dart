import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/styles/text_styles.dart';

/// CollectionTile widget displays a single collection with image background,
/// overlay text, and tap feedback via Material InkWell.
///
/// When tapped, automatically navigates to the collection details page
/// using the collection's slug for the URL path.
class CollectionTile extends StatelessWidget {
  final Collection collection;

  const CollectionTile({
    super.key,
    required this.collection,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context.go('/collections/${collection.slug}');
        },
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
