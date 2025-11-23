import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/widgets/control_section.dart';
import 'package:union_shop/widgets/product_card.dart';

/// A page widget that displays a collection of products in a responsive grid.
///
/// Features:
/// - Header with collection title and description
/// - Filter and sort control section
/// - Responsive grid (2 columns on mobile, 3 on tablet/desktop)
/// - Product cards with tap feedback
class CollectionPage extends StatelessWidget {
  final Collection collection;

  const CollectionPage({
    super.key,
    required this.collection,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collection.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  collection.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
              ],
            ),
          ),
          // Control Section
          const ControlSection(),
          // Products Grid
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildProductGrid(context),
          ),
        ],
      ),
    );
  }

  /// Builds a responsive product grid based on screen width.
  Widget _buildProductGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int columnCount;

    if (screenWidth < 600) {
      columnCount = 2;
    } else if (screenWidth < 900) {
      columnCount = 3;
    } else {
      columnCount = 3;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: collection.items.length,
      itemBuilder: (context, index) {
        final product = collection.items[index];
        return ProductCard(product: product);
      },
    );
  }
}
