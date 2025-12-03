import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/screens/print_shack_form_page.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('PrintShackFormPage Widget Tests', () {
    testWidgets('displays page title', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      expect(find.text('Personalise Your Item'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays Description section', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      expect(find.text('Description'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays description text', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      expect(
        find.textContaining('Add custom text to your merchandise'),
        findsOneWidget,
      );

      await tester.resetViewportSize();
    });

    testWidgets('displays Number of Lines section', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      expect(find.text('Number of Lines'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays line count dropdown', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      expect(find.byType(DropdownButtonFormField<int>), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays Your Text section', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      expect(find.text('Your Text'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('shows one text field by default', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsNothing);

      await tester.resetViewportSize();
    });

    testWidgets('displays Preview Personalisation button', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      expect(find.text('Preview Personalisation'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('shows more text fields when line count increases',
        (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      // Open line count dropdown
      await tester.tap(find.text('1 line'));
      await tester.pumpAndSettle();

      // Select 3 lines
      await tester.tap(find.text('3 lines').last);
      await tester.pumpAndSettle();

      // Should now show 3 text fields
      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
      expect(find.text('Line 3'), findsOneWidget);
      expect(find.text('Line 4'), findsNothing);

      await tester.resetViewportSize();
    });

    testWidgets('shows all 4 text fields when 4 lines selected',
        (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      // Open line count dropdown
      await tester.tap(find.text('1 line'));
      await tester.pumpAndSettle();

      // Select 4 lines
      await tester.tap(find.text('4 lines').last);
      await tester.pumpAndSettle();

      // Should now show 4 text fields
      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
      expect(find.text('Line 3'), findsOneWidget);
      expect(find.text('Line 4'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('text field character counter updates', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      // Text fields with maxLength show a counter like "0/20"
      // Enter some text and verify counter updates
      await tester.enterText(find.byType(TextFormField).first, 'Test');
      await tester.pumpAndSettle();

      // Should show character counter
      expect(find.textContaining('4/20'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('shows snackbar when submitting empty form', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      // Tap submit button without entering text
      await tester.tap(find.text('Preview Personalisation'));
      await tester.pumpAndSettle();

      // Should show error snackbar
      expect(
        find.text('Please enter text for at least one line'),
        findsOneWidget,
      );

      await tester.resetViewportSize();
    });

    testWidgets('shows preview snackbar when form has content', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      // Enter text in line 1
      await tester.enterText(find.byType(TextFormField).first, 'Hello World');
      await tester.pumpAndSettle();

      // Tap submit button
      await tester.tap(find.text('Preview Personalisation'));
      await tester.pumpAndSettle();

      // Should show preview snackbar with the text
      expect(find.textContaining('Line 1: Hello World'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('clears text when reducing line count', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackFormPage()),
      );

      // Select 2 lines
      await tester.tap(find.text('1 line'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('2 lines').last);
      await tester.pumpAndSettle();

      // Enter text in line 2
      await tester.enterText(find.byType(TextFormField).at(1), 'Line 2 text');
      await tester.pumpAndSettle();

      // Reduce back to 1 line
      await tester.tap(find.text('2 lines'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1 line').last);
      await tester.pumpAndSettle();

      // Line 2 field should not be visible
      expect(find.text('Line 2'), findsNothing);

      await tester.resetViewportSize();
    });
  });
}
