import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/styles/text_styles.dart';
import 'package:union_shop/widgets/control_section.dart';
import 'package:union_shop/widgets/product_card.dart';

/// A page widget that displays a collection of products in a responsive grid.
///
/// Features:
/// - Header with collection title and description
/// - Filter and sort control section
/// - Responsive grid (2 columns on mobile, 3 on tablet/desktop)
/// - Product cards with tap feedback
/// - Sorting functionality (by name and price)
class CollectionPage extends StatefulWidget {
  final Collection collection;

  const CollectionPage({
    super.key,
    required this.collection,
  });

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late List<Product> _displayedProducts;
  late List<Product> _allProducts;
  String _currentSort = 'name';
  String _currentFilter = 'all';

  @override
  void initState() {
    super.initState();
    _allProducts = List.from(widget.collection.items);
    _displayedProducts = List.from(_allProducts);
    _applySorting(_currentSort);
  }

  void _applyFiltering(String filterOption) {
    setState(() {
      _currentFilter = filterOption;
      _displayedProducts = _allProducts.where((product) {
        if (filterOption == 'all') {
          return true;
        } else if (filterOption == 'product') {
          return product.category == ProductCategory.product;
        } else if (filterOption == 'merchandise') {
          return product.category == ProductCategory.merchandise;
        }
        return true;
      }).toList();
      _applySorting(_currentSort);
    });
  }

  void _applySorting(String sortOption) {
    setState(() {
      _currentSort = sortOption;
      switch (sortOption) {
        case 'name':
          _displayedProducts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'price_low':
          _displayedProducts.sort((a, b) {
            final priceA = a.discountedPrice ?? a.price;
            final priceB = b.discountedPrice ?? b.price;
            return priceA.compareTo(priceB);
          });
          break;
        case 'price_high':
          _displayedProducts.sort((a, b) {
            final priceA = a.discountedPrice ?? a.price;
            final priceB = b.discountedPrice ?? b.price;
            return priceB.compareTo(priceA);
          });
          break;
      }
    });
  }

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
                  widget.collection.title,
                  style: TextStyles.collectionPageHeading,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.collection.description,
                  style: TextStyles.collectionPageDescription,
                ),
              ],
            ),
          ),
          // Control Section
          ControlSection(
            currentSort: _currentSort,
            currentFilter: _currentFilter,
            onSortChanged: _applySorting,
            onFilterChanged: _applyFiltering,
          ),
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
      itemCount: _displayedProducts.length,
      itemBuilder: (context, index) {
        final product = _displayedProducts[index];
        return ProductCard(product: product);
      },
    );
  }
}
