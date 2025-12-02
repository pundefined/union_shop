import 'package:flutter/material.dart';
import 'package:union_shop/widgets/labeled_dropdown_selector.dart';

/// A dropdown selector for choosing a color from a list of options.
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
    return LabeledDropdownSelector<String>(
      label: 'Colour',
      hint: 'Select a colour',
      options: colors,
      selectedValue: selectedColour,
      onChanged: onChanged,
    );
  }
}
