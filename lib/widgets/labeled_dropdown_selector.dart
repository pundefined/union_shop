import 'package:flutter/material.dart';
import 'package:union_shop/styles/text_styles.dart';

/// A generic labeled dropdown selector widget.
///
/// Displays a label above a dropdown button for selecting from a list of options.
/// Used as the base for [ColorSelector] and [SizeSelector].
class LabeledDropdownSelector<Option> extends StatelessWidget {
  /// The label text displayed above the dropdown.
  final String label;

  /// The hint text shown when no value is selected.
  final String hint;

  /// The list of available options.
  final List<Option> options;

  /// The currently selected value, or null if nothing selected.
  final Option? selectedValue;

  /// Callback when the selection changes.
  final ValueChanged<Option?> onChanged;

  /// Function to convert an option to its display string.
  /// Defaults to calling `toString()` on the option.
  final String Function(Option)? displayStringForOption;

  const LabeledDropdownSelector({
    super.key,
    required this.label,
    required this.hint,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.displayStringForOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.subHeading,
        ),
        const SizedBox(height: 8),
        DropdownButton<Option>(
          value: selectedValue,
          hint: Text(hint),
          isExpanded: true,
          items: options.map((Option option) {
            final displayText =
                displayStringForOption?.call(option) ?? option.toString();
            return DropdownMenuItem<Option>(
              value: option,
              child: Text(displayText),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
