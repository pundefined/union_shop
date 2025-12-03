import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/size_selector.dart';

void main() {
  group('SizeSelector Widget', () {
    testWidgets('displays label "Size"', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizeSelector(
              sizes: const ['S', 'M'],
              selectedSize: null,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Size'), findsOneWidget);
    });

    testWidgets('displays dropdown with size options',
        (WidgetTester tester) async {
      const sizes = ['XS', 'S', 'M', 'L', 'XL'];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizeSelector(
              sizes: sizes,
              selectedSize: null,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Tap dropdown to open it
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Check all sizes are present
      for (final size in sizes) {
        expect(find.text(size), findsWidgets);
      }
    });

    testWidgets('calls onChanged when size is selected',
        (WidgetTester tester) async {
      String? selectedSize;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return SizeSelector(
                  sizes: const ['XS', 'S', 'M', 'L', 'XL'],
                  selectedSize: selectedSize,
                  onChanged: (newSize) {
                    setState(() {
                      selectedSize = newSize;
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

      // Select 'M'
      await tester.tap(find.text('M').last);
      await tester.pumpAndSettle();

      // Verify the callback was called
      expect(selectedSize, 'M');
    });

    testWidgets('displays selected size in dropdown',
        (WidgetTester tester) async {
      const sizes = ['XS', 'S', 'M', 'L', 'XL'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizeSelector(
              sizes: sizes,
              selectedSize: 'L',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // The selected value should be displayed
      expect(find.text('L'), findsWidgets);
    });
  });
}
