import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/screens/search_page.dart';

void main() {
  group('Search Page Tests', () {
    Widget createTestWidget({String? initialQuery}) {
      return MaterialApp(
        home: Scaffold(
          body: SearchPage(initialQuery: initialQuery),
        ),
      );
    }

    testWidgets('displays search heading', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Search Products'), findsOneWidget);
    });

    testWidgets('displays search input field', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('shows results when searching for existing product',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Enter search term and submit
      await tester.enterText(find.byType(TextField), 'hoodie');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // Should show results count
      expect(find.textContaining('found'), findsOneWidget);
    });

    testWidgets('shows empty state when no results found', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Enter search term that won't match anything
      await tester.enterText(find.byType(TextField), 'xyznonexistent123');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(find.text('No products found'), findsOneWidget);
      expect(find.text('Try a different search term'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);
    });

    testWidgets('pre-fills search input with initialQuery', (tester) async {
      await tester.pumpWidget(createTestWidget(initialQuery: 'backpack'));
      await tester.pump();

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, 'backpack');
    });

    testWidgets('performs search automatically with initialQuery',
        (tester) async {
      await tester.pumpWidget(createTestWidget(initialQuery: 'hoodie'));
      await tester.pumpAndSettle();

      // Should show results
      expect(find.textContaining('found'), findsOneWidget);
    });

    testWidgets('clears results when searching with empty string',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // First search for something
      await tester.enterText(find.byType(TextField), 'hoodie');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(find.textContaining('results found'), findsOneWidget);

      // Now clear and search empty
      await tester.enterText(find.byType(TextField), '');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // Should not show results count or empty state
      expect(find.textContaining('results found'), findsNothing);
      expect(find.text('No products found'), findsNothing);
    });
  });
}
