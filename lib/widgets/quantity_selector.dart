import 'package:flutter/material.dart';

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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
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
