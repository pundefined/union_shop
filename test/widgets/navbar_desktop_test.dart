import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/navbar_desktop.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('DesktopNavLinks Widget Tests', () {
    testWidgets('displays Home link', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidget(const Row(children: [DesktopNavLinks()])),
      );

      expect(find.text('Home'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays Sale link', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidget(const Row(children: [DesktopNavLinks()])),
      );

      expect(find.text('Sale'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays About link', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidget(const Row(children: [DesktopNavLinks()])),
      );

      expect(find.text('About'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays Shop dropdown', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidget(const Row(children: [DesktopNavLinks()])),
      );

      expect(find.text('Shop'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays Print Shack dropdown', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidget(const Row(children: [DesktopNavLinks()])),
      );

      expect(find.text('Print Shack'), findsOneWidget);

      await tester.resetViewportSize();
    });
  });

  group('ShopDropdown Widget Tests', () {
    testWidgets('displays Shop text with dropdown icon', (tester) async {
      await tester.pumpWidget(
        wrapWidget(const ShopDropdown()),
      );

      expect(find.text('Shop'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    });

    testWidgets('opens popup menu on tap', (tester) async {
      await tester.pumpWidget(
        wrapWidget(const ShopDropdown()),
      );

      await tester.tap(find.text('Shop'));
      await tester.pumpAndSettle();

      // Should show collection items in the popup
      expect(find.text('Essentials'), findsOneWidget);
    });

    testWidgets('has Semantics widget for accessibility', (tester) async {
      await tester.pumpWidget(
        wrapWidget(const ShopDropdown()),
      );

      // Find Semantics widget with label
      final semantics = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label == 'Shop' &&
            widget.properties.button == true,
      );
      expect(semantics, findsOneWidget);
    });
  });

  group('PrintShackDropdown Widget Tests', () {
    testWidgets('displays Print Shack text with dropdown icon', (tester) async {
      await tester.pumpWidget(
        wrapWidget(const PrintShackDropdown()),
      );

      expect(find.text('Print Shack'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    });

    testWidgets('opens popup menu on tap', (tester) async {
      await tester.pumpWidget(
        wrapWidget(const PrintShackDropdown()),
      );

      await tester.tap(find.text('Print Shack'));
      await tester.pumpAndSettle();

      // Should show Personalise and About options
      expect(find.text('Personalise'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });
  });
}
