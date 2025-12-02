import 'package:flutter/material.dart';
import 'package:union_shop/styles/text_styles.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity',
          style: TextStyles.subHeading,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Decrease button
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
              tooltip: 'Decrease quantity',
            ),
            // Quantity display
            Container(
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  quantity.toString(),
                  style: TextStyles.quantityDisplay,
                ),
              ),
            ),
            // Increase button
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onChanged(quantity + 1),
              tooltip: 'Increase quantity',
            ),
          ],
        ),
      ],
    );
  }
}
