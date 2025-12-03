import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/utils/responsive.dart';
import 'package:union_shop/widgets/collection_tile.dart';

/// The collections page content widget.
class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnCount = Responsive.getGridColumnCount(constraints.maxWidth);

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
          itemCount: storeCollections.length,
          itemBuilder: (context, index) {
            return CollectionTile(
              collection: storeCollections[index],
            );
          },
        );
      },
    );
  }
}
