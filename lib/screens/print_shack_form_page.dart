import 'package:flutter/material.dart';
import '../styles/text_styles.dart';
import '../widgets/page_content.dart';

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
  /// Maximum characters allowed per line
  static const int _maxCharactersPerLine = 20;

  /// Currently selected number of lines (1-4)
  int _selectedLineCount = 1;

  /// Controllers for each text input line
  late List<TextEditingController> _lineControllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for all 4 possible lines
    _lineControllers = List.generate(
      4,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    // Clean up controllers to prevent memory leaks
    for (final controller in _lineControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContent(
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
                      // Clear text from lines that will be hidden
                      for (int i = value; i < 4; i++) {
                        _lineControllers[i].clear();
                      }
                      _selectedLineCount = value;
                    });
                  }
                },
              ),

              // Text input fields
              const SizedBox(height: 24),
              const Text(
                'Your Text',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 8),
              for (int i = 0; i < _selectedLineCount; i++) ...[
                if (i > 0) const SizedBox(height: 16),
                TextFormField(
                  controller: _lineControllers[i],
                  maxLength: _maxCharactersPerLine,
                  decoration: InputDecoration(
                    labelText: 'Line ${i + 1}',
                    hintText: 'Enter text for line ${i + 1}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  textInputAction: i < _selectedLineCount - 1
                      ? TextInputAction.next
                      : TextInputAction.done,
                ),
              ],

              // Submit button
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Preview Personalisation'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleSubmit() {
    // Collect text from visible lines
    final lines = <String>[];
    for (int i = 0; i < _selectedLineCount; i++) {
      lines.add(_lineControllers[i].text.trim());
    }

    // Check if at least one line has content
    final hasContent = lines.any((line) => line.isNotEmpty);

    if (!hasContent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter text for at least one line'),
        ),
      );
      return;
    }

    // Show preview snackbar with all lines
    final preview = lines
        .asMap()
        .entries
        .map((e) =>
            'Line ${e.key + 1}: ${e.value.isEmpty ? "(empty)" : e.value}')
        .join(', ');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(preview),
      ),
    );
  }
}
