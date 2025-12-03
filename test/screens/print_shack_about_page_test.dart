import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/screens/print_shack_about_page.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('PrintShackAboutPage Widget Tests', () {
    testWidgets('displays page title', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackAboutPage()),
      );

      expect(find.text('The Print Shack'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays About Our Service section', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackAboutPage()),
      );

      expect(find.text('About Our Service'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays service description text', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackAboutPage()),
      );

      expect(
        find.textContaining('exclusive personalisation service'),
        findsOneWidget,
      );

      await tester.resetViewportSize();
    });

    testWidgets('displays Guidelines section', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackAboutPage()),
      );

      expect(find.text('Guidelines'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays guideline items', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackAboutPage()),
      );

      expect(find.textContaining('Up to 4 lines'), findsOneWidget);
      expect(find.textContaining('Maximum 20 characters'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays Pricing section', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackAboutPage()),
      );

      expect(find.text('Pricing'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays pricing options', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackAboutPage()),
      );

      expect(find.textContaining('1 line: £3.00'), findsOneWidget);
      expect(find.textContaining('2 lines: £5.00'), findsOneWidget);
      expect(find.textContaining('3 lines: £7.00'), findsOneWidget);
      expect(find.textContaining('4 lines: £8.50'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays Ready to personalise section', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackAboutPage()),
      );

      expect(find.text('Ready to personalise?'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays Start Personalising button', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(const PrintShackAboutPage()),
      );

      expect(find.text('Start Personalising'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.resetViewportSize();
    });
  });
}
