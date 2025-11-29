import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/styles/text_styles.dart';

/// Shopping cart page displaying cart items, total price, and checkout button.
class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    if (cart.isEmpty) {
      return _buildEmptyCart(context);
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text('Shopping Cart', style: TextStyles.productHeading),
              const SizedBox(height: 8),
              Text(
                '${cart.itemCount} ${cart.itemCount == 1 ? 'item' : 'items'}',
                style: TextStyles.bodyText,
              ),
              const SizedBox(height: 24),

              // Cart items
              for (final item in cart.items) ...[
                _buildCartItem(context, item, cart),
                const Divider(height: 32),
              ],

              // Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyles.productHeading),
                  Text(
                    '£${cart.totalPrice.toStringAsFixed(2)}',
                    style: TextStyles.productHeading,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Checkout functionality coming soon!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF4d2963),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Checkout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: TextStyles.productHeading,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              'Looks like you haven\'t added any items yet.',
              style: TextStyles.bodyText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(
      BuildContext context, CartItem item, CartProvider cart) {
    final unitPrice = item.product.discountedPrice ?? item.product.price;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.product.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 80,
              height: 80,
              color: Colors.grey[200],
              child: const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.product.name, style: TextStyles.subHeading),
              if (item.selectedColor != null || item.selectedSize != null)
                Text(
                  [item.selectedColor, item.selectedSize]
                      .where((e) => e != null)
                      .join(' / '),
                  style: TextStyles.bodySmall,
                ),
              const SizedBox(height: 4),
              Text(
                '£${unitPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4d2963),
                ),
              ),
            ],
          ),
        ),

        // Quantity & Remove
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Quantity controls
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () =>
                      cart.updateQuantity(item.uniqueKey, item.quantity - 1),
                ),
                Text('${item.quantity}', style: TextStyles.subHeading),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () =>
                      cart.updateQuantity(item.uniqueKey, item.quantity + 1),
                ),
              ],
            ),
            TextButton(
              onPressed: () => cart.removeItem(item.uniqueKey),
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }
}
