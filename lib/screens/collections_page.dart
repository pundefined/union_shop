import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/widgets/collection_tile.dart';

/// The collections page content widget.
class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

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
            );
          },
        );
      },
    );
  }
}
