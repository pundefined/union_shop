import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/screens/home.dart';
import 'package:union_shop/widgets/carousel.dart';
import 'package:union_shop/widgets/product_section.dart';
import 'package:union_shop/widgets/collection_tile.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('displays carousel', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(wrapWidgetScrollable(const HomeScreen()));
      await tester.pump();

      expect(find.byType(Carousel), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays product sections', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(wrapWidgetScrollable(const HomeScreen()));
      await tester.pump();

      expect(find.byType(ProductSection), findsWidgets);
      expect(
        find.descendant(
          of: find.byType(ProductSection),
          matching: find.text('Summer Sale'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(ProductSection),
          matching: find.text('New Arrivals'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(ProductSection),
          matching: find.text('Essentials'),
        ),
        findsOneWidget,
      );

      await tester.resetViewportSize();
    });

    testWidgets('displays OUR RANGE section with collection tiles',
        (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(wrapWidgetScrollable(const HomeScreen()));
      await tester.pump();

      expect(find.text('OUR RANGE'), findsOneWidget);
      expect(find.byType(CollectionTile), findsWidgets);

      await tester.resetViewportSize();
    });

    testWidgets('displays carousel navigation buttons', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(wrapWidgetScrollable(const HomeScreen()));
      await tester.pump();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays VIEW ALL button in Featured Collection',
        (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(wrapWidgetScrollable(const HomeScreen()));
      await tester.pump();

      expect(find.text('VIEW ALL'), findsOneWidget);

      await tester.resetViewportSize();
    });
  });
}
