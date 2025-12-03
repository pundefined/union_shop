import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/widgets/product_section.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('ProductSection Widget Tests', () {
    final testProducts = [
      Product(
        id: 'test-1',
        name: 'Product 1',
        price: 19.99,
        imageUrl: 'assets/images/backpack.png',
        description: 'Description 1',
        category: ProductCategory.product,
      ),
      Product(
        id: 'test-2',
        name: 'Product 2',
        price: 29.99,
        imageUrl: 'assets/images/backpack.png',
        description: 'Description 2',
        category: ProductCategory.product,
      ),
    ];

    testWidgets('displays section title', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(
          ProductSection(
            title: 'Featured Products',
            products: testProducts,
          ),
        ),
      );

      expect(find.text('Featured Products'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays product cards for each product', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(
          ProductSection(
            title: 'Featured Products',
            products: testProducts,
          ),
        ),
      );

      expect(find.byType(ProductCard), findsNWidgets(testProducts.length));

      await tester.resetViewportSize();
    });

    testWidgets('hides View All button by default', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(
          ProductSection(
            title: 'Featured Products',
            products: testProducts,
          ),
        ),
      );

      expect(find.text('VIEW ALL'), findsNothing);

      await tester.resetViewportSize();
    });

    testWidgets('shows View All button when showViewAll is true',
        (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(
          ProductSection(
            title: 'Featured Products',
            products: testProducts,
            showViewAll: true,
          ),
        ),
      );

      expect(find.text('VIEW ALL'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('calls onViewAllPressed when View All is tapped',
        (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      bool viewAllPressed = false;

      await tester.pumpWidget(
        wrapWidgetScrollable(
          ProductSection(
            title: 'Featured Products',
            products: testProducts,
            showViewAll: true,
            onViewAllPressed: () => viewAllPressed = true,
          ),
        ),
      );

      await tester.tap(find.text('VIEW ALL'));
      await tester.pump();

      expect(viewAllPressed, isTrue);

      await tester.resetViewportSize();
    });

    testWidgets('renders GridView with products', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(
          ProductSection(
            title: 'Featured Products',
            products: testProducts,
          ),
        ),
      );

      expect(find.byType(GridView), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('handles empty product list', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetScrollable(
          const ProductSection(
            title: 'Empty Section',
            products: [],
          ),
        ),
      );

      expect(find.text('Empty Section'), findsOneWidget);
      expect(find.byType(ProductCard), findsNothing);

      await tester.resetViewportSize();
    });
  });
}
