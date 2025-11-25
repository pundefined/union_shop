import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/styles/text_styles.dart';
import 'product_card.dart';

/// A reusable widget that displays a product section with a header and grid of products.
/// Optionally displays a "View All" button at the bottom.
class ProductSection extends StatelessWidget {
  final String title;
  final List<Product> products;
  final VoidCallback? onViewAllPressed;
  final bool showViewAll;

  const ProductSection({
    super.key,
    required this.title,
    required this.products,
    this.onViewAllPressed,
    this.showViewAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.sectionHeading,
        ),
        const SizedBox(height: 32),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
          crossAxisSpacing: 24,
          mainAxisSpacing: 48,
          children:
              products.map((product) => ProductCard(product: product)).toList(),
        ),
        if (showViewAll) ...[
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: onViewAllPressed,
              child: const Text('VIEW ALL'),
            ),
          ),
        ],
      ],
    );
  }
}
