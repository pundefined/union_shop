import 'package:flutter/material.dart';
import 'package:union_shop/widgets/labeled_dropdown_selector.dart';

/// A dropdown selector for choosing a size from a list of options.
class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String? selectedSize;
  final ValueChanged<String?> onChanged;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledDropdownSelector<String>(
      label: 'Size',
      hint: 'Select a size',
      options: sizes,
      selectedValue: selectedSize,
      onChanged: onChanged,
    );
  }
}
