import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/labeled_dropdown_selector.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('LabeledDropdownSelector Widget Tests', () {
    testWidgets('displays label text', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          LabeledDropdownSelector<String>(
            label: 'Select Option',
            hint: 'Choose one',
            options: const ['Option 1', 'Option 2'],
            selectedValue: null,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Select Option'), findsOneWidget);
    });

    testWidgets('displays hint when no value selected', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          LabeledDropdownSelector<String>(
            label: 'Select Option',
            hint: 'Choose one',
            options: const ['Option 1', 'Option 2'],
            selectedValue: null,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Choose one'), findsOneWidget);
    });

    testWidgets('displays selected value', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          LabeledDropdownSelector<String>(
            label: 'Select Option',
            hint: 'Choose one',
            options: const ['Option 1', 'Option 2'],
            selectedValue: 'Option 1',
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
    });

    testWidgets('shows options when dropdown is tapped', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          LabeledDropdownSelector<String>(
            label: 'Select Option',
            hint: 'Choose one',
            options: const ['Option 1', 'Option 2', 'Option 3'],
            selectedValue: null,
            onChanged: (_) {},
          ),
        ),
      );

      // Tap the dropdown
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // All options should be visible
      expect(find.text('Option 1'), findsWidgets);
      expect(find.text('Option 2'), findsWidgets);
      expect(find.text('Option 3'), findsWidgets);
    });

    testWidgets('calls onChanged when option is selected', (tester) async {
      String? selectedOption;

      await tester.pumpWidget(
        wrapWidget(
          LabeledDropdownSelector<String>(
            label: 'Select Option',
            hint: 'Choose one',
            options: const ['Option 1', 'Option 2'],
            selectedValue: null,
            onChanged: (value) => selectedOption = value,
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Select 'Option 2'
      await tester.tap(find.text('Option 2').last);
      await tester.pumpAndSettle();

      expect(selectedOption, 'Option 2');
    });

    testWidgets('uses custom displayStringForOption', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          LabeledDropdownSelector<int>(
            label: 'Select Number',
            hint: 'Choose a number',
            options: const [1, 2, 3],
            selectedValue: 2,
            onChanged: (_) {},
            displayStringForOption: (value) => 'Number $value',
          ),
        ),
      );

      expect(find.text('Number 2'), findsOneWidget);
    });

    testWidgets('dropdown is expanded (isExpanded: true)', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          LabeledDropdownSelector<String>(
            label: 'Select Option',
            hint: 'Choose one',
            options: const ['Option 1', 'Option 2'],
            selectedValue: null,
            onChanged: (_) {},
          ),
        ),
      );

      final dropdown = tester.widget<DropdownButton<String>>(
        find.byType(DropdownButton<String>),
      );
      expect(dropdown.isExpanded, isTrue);
    });

    testWidgets('works with enum options', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          LabeledDropdownSelector<_TestEnum>(
            label: 'Select Enum',
            hint: 'Choose enum',
            options: _TestEnum.values,
            selectedValue: _TestEnum.optionB,
            onChanged: (_) {},
            displayStringForOption: (e) => e.name.toUpperCase(),
          ),
        ),
      );

      expect(find.text('OPTIONB'), findsOneWidget);
    });
  });
}

enum _TestEnum { optionA, optionB, optionC }
