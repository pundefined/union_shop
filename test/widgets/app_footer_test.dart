import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/app_footer.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('AppFooter Widget Tests', () {
    testWidgets('renders opening hours and static content',
        (WidgetTester tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(wrapWidget(const AppFooter()));

      // Verify heading and some expected lines are present
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Purchase online 24/7'), findsOneWidget);

      // Verify clickable items exist
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Terms & Conditions of Sale Policy'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('clickable items have tap handlers',
        (WidgetTester tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(wrapWidget(const AppFooter()));

      // Find InkWell widgets that wrap the clickable text
      final searchInkWell = find.ancestor(
        of: find.text('Search'),
        matching: find.byType(InkWell),
      );
      final termsInkWell = find.ancestor(
        of: find.text('Terms & Conditions of Sale Policy'),
        matching: find.byType(InkWell),
      );

      expect(searchInkWell, findsOneWidget);
      expect(termsInkWell, findsOneWidget);

      // Verify the InkWells have onTap handlers (are interactive)
      final searchWidget = tester.widget<InkWell>(searchInkWell);
      final termsWidget = tester.widget<InkWell>(termsInkWell);

      expect(searchWidget.onTap, isNotNull);
      expect(termsWidget.onTap, isNotNull);

      await tester.resetViewportSize();
    });
  });
}
