import 'package:flutter/material.dart';
import '../styles/text_styles.dart';

/// PrintShackFormPage provides a personalisation form allowing users to
/// configure custom text for their items with 1-4 printed lines.
/// This is a UI-only feature; personalisation is not implemented as a
/// purchasable product.
class PrintShackFormPage extends StatefulWidget {
  const PrintShackFormPage({super.key});

  @override
  State<PrintShackFormPage> createState() => _PrintShackFormPageState();
}

class _PrintShackFormPageState extends State<PrintShackFormPage> {
  /// Currently selected number of lines (1-4)
  int _selectedLineCount = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Form content
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page heading
              const Text(
                'Personalise Your Item',
                style: TextStyles.productHeading,
              ),

              const SizedBox(height: 24),

              // Description
              const Text(
                'Description',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 8),
              const Text(
                'Add custom text to your merchandise with up to 4 lines of personalisation. '
                'Perfect for names, dates, messages, or anything else you\'d like to add!',
                style: TextStyles.bodyText,
              ),

              // Line count selector
              const SizedBox(height: 24),
              const Text(
                'Number of Lines',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                initialValue: _selectedLineCount,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                items: List.generate(
                  4,
                  (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('${index + 1} line${index == 0 ? '' : 's'}'),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedLineCount = value;
                    });
                  }
                },
              ),

              // TODO: Text input fields will be added in subtask 3

              // TODO: Submit button will be added in subtask 3
            ],
          ),
        ),
      ],
    );
  }
}
