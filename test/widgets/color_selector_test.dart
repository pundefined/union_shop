import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/color_selector.dart';

void main() {
  group('ColorSelector Widget', () {
    testWidgets('displays label "Colour"', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorSelector(
              colors: const ['Red', 'Blue'],
              selectedColour: null,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Colour'), findsOneWidget);
    });

    testWidgets('displays dropdown with colour options',
        (WidgetTester tester) async {
      const colors = ['Red', 'Blue', 'Green'];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorSelector(
              colors: colors,
              selectedColour: null,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Tap dropdown to open it
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Check all colours are present
      for (final colour in colors) {
        expect(find.text(colour), findsWidgets);
      }
    });

    testWidgets('calls onChanged when colour is selected',
        (WidgetTester tester) async {
      String? selectedColour;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return ColorSelector(
                  colors: const ['Red', 'Blue', 'Green'],
                  selectedColour: selectedColour,
                  onChanged: (newColour) {
                    setState(() {
                      selectedColour = newColour;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Select 'Red'
      await tester.tap(find.text('Red').last);
      await tester.pumpAndSettle();

      // Verify the callback was called
      expect(selectedColour, 'Red');
    });

    testWidgets('displays selected colour in dropdown',
        (WidgetTester tester) async {
      const colors = ['Red', 'Blue', 'Green'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorSelector(
              colors: colors,
              selectedColour: 'Blue',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // The selected value should be displayed
      expect(find.text('Blue'), findsWidgets);
    });

    testWidgets('has proper widget structure', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorSelector(
              colors: const ['Red', 'Blue'],
              selectedColour: null,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Check Column exists
      expect(find.byType(Column), findsOneWidget);
      // Check DropdownButton exists
      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });
  });
}
