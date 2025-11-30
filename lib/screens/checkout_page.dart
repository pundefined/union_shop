import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/styles/text_styles.dart';

/// Checkout page displaying order summary and allowing users to place their order.
/// Shows all cart items with details, price breakdown, and a Place Order button.
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    // If cart is empty, show message and option to continue shopping
    if (cart.isEmpty) {
      return _buildEmptyCheckout(context);
    }

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text('Order Summary', style: TextStyles.productHeading),
                const SizedBox(height: 8),
                Text(
                  '${cart.itemCount} ${cart.itemCount == 1 ? 'item' : 'items'}',
                  style: TextStyles.bodyText,
                ),
                const SizedBox(height: 24),

                // Order items
                _buildOrderItemsList(cart),

                // TODO: Price breakdown will be added in subsequent subtask

                // TODO: Place Order button will be added in subsequent subtask
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCheckout(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 24),
            const Text(
              'Your cart is empty',
              style: TextStyles.productHeading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Add some items to your cart before checking out.',
              style: TextStyles.bodyText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsList(CartProvider cart) {
    return Column(
      children: [
        for (int i = 0; i < cart.items.length; i++) ...[
          _buildOrderItem(cart.items[i]),
          if (i < cart.items.length - 1) const Divider(height: 32),
        ],
      ],
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.product.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            semanticLabel: item.product.name,
            errorBuilder: (_, __, ___) => Container(
              width: 80,
              height: 80,
              color: Colors.grey[200],
              child: const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Product details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.product.name, style: TextStyles.subHeading),
              if (item.selectedColor != null || item.selectedSize != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    [item.selectedColor, item.selectedSize]
                        .where((e) => e != null)
                        .join(' / '),
                    style: TextStyles.bodySmall,
                  ),
                ),
              const SizedBox(height: 4),
              Text(
                'Qty: ${item.quantity}',
                style: TextStyles.bodySmall,
              ),
            ],
          ),
        ),

        // Item total price
        Text(
          '£${item.totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4d2963),
          ),
        ),
      ],
    );
  }
}
