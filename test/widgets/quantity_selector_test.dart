import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/quantity_selector.dart';

void main() {
  group('QuantitySelector Widget', () {
    testWidgets('displays label "Quantity"', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              quantity: 1,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Quantity'), findsOneWidget);
    });

    testWidgets('displays current quantity', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              quantity: 5,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('increase button increments quantity',
        (WidgetTester tester) async {
      int quantity = 1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return QuantitySelector(
                  quantity: quantity,
                  onChanged: (newQuantity) {
                    setState(() {
                      quantity = newQuantity;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);

      // Find and tap the increase button (the second IconButton)
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
      expect(quantity, 2);
    });

    testWidgets('decrease button decrements quantity',
        (WidgetTester tester) async {
      int quantity = 3;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return QuantitySelector(
                  quantity: quantity,
                  onChanged: (newQuantity) {
                    setState(() {
                      quantity = newQuantity;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);

      // Find and tap the decrease button (the first IconButton)
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
      expect(quantity, 2);
    });

    testWidgets('decrease button is disabled when quantity is 1',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              quantity: 1,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Find the decrease button (first IconButton)
      final iconButtons = find.byType(IconButton);

      // The first IconButton should be disabled
      expect(
        tester.widget<IconButton>(iconButtons.first).onPressed,
        isNull,
      );
    });

    testWidgets('increase button is always enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              quantity: 1,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Find the increase button (second IconButton)
      final iconButtons = find.byType(IconButton);

      // The second IconButton should be enabled
      expect(
        tester.widget<IconButton>(iconButtons.at(1)).onPressed,
        isNotNull,
      );
    });

    testWidgets('has proper widget structure', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              quantity: 1,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Check Column exists
      expect(find.byType(Column), findsOneWidget);
      // Check Row exists (for buttons and display)
      expect(find.byType(Row), findsOneWidget);
      // Check IconButtons exist (increase and decrease)
      expect(find.byType(IconButton), findsWidgets);
      // Check Container exists (for quantity display)
      expect(find.byType(Container), findsOneWidget);
      // Check Text exists
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('calls onChanged with correct value',
        (WidgetTester tester) async {
      int? changedQuantity;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              quantity: 2,
              onChanged: (newQuantity) {
                changedQuantity = newQuantity;
              },
            ),
          ),
        ),
      );

      // Tap increase button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(changedQuantity, 3);
    });
  });
}
