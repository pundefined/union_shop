import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/styles/text_styles.dart';
import 'package:union_shop/widgets/app_image.dart';

/// A reusable widget that displays a single product card in a grid.
/// Tapping the card navigates to the product detail page at /products/{slug}.
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/products/${product.slug}'),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: AppImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyles.productCardTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  if (product.discountedPrice != null)
                    Row(
                      children: [
                        Text(
                          '£${product.price.toStringAsFixed(2)}',
                          style: TextStyles.productPrice.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '£${product.discountedPrice!.toStringAsFixed(2)}',
                          style: TextStyles.productPrice.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: TextStyles.productPrice,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
