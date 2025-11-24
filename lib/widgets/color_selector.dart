import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<String> colors;
  final String? selectedColour;
  final ValueChanged<String?> onChanged;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedColour,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Colour',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          value: selectedColour,
          hint: const Text('Select a colour'),
          isExpanded: true,
          items: colors.map((String colour) {
            return DropdownMenuItem<String>(
              value: colour,
              child: Text(colour),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
