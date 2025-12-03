import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('ProductCard Widget Tests', () {
    final testProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      price: 24.99,
      imageUrl: 'assets/images/backpack.png',
      description: 'A test product description',
      category: ProductCategory.product,
    );

    final discountedProduct = Product(
      id: 'test-2',
      name: 'Discounted Product',
      price: 49.99,
      discountedPrice: 34.99,
      imageUrl: 'assets/images/backpack.png',
      description: 'A discounted product',
      category: ProductCategory.product,
    );

    testWidgets('displays product name', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 300,
            width: 200,
            child: ProductCard(product: testProduct),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('displays product price', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 300,
            width: 200,
            child: ProductCard(product: testProduct),
          ),
        ),
      );

      expect(find.text('£24.99'), findsOneWidget);
    });

    testWidgets('displays discounted price when available', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 400,
            width: 400,
            child: ProductCard(product: discountedProduct),
          ),
        ),
      );

      // Original price should have strikethrough
      expect(find.text('£49.99'), findsOneWidget);
      // Discounted price should be shown
      expect(find.text('£34.99'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('renders product image', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 300,
            width: 200,
            child: ProductCard(product: testProduct),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('has InkWell for tap feedback', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 300,
            width: 200,
            child: ProductCard(product: testProduct),
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('renders inside a Card widget', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 300,
            width: 200,
            child: ProductCard(product: testProduct),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('truncates long product names', (tester) async {
      final longNameProduct = Product(
        id: 'test-long',
        name:
            'This is a very long product name that should be truncated after two lines',
        price: 19.99,
        imageUrl: 'assets/images/backpack.png',
        description: 'Description',
        category: ProductCategory.product,
      );

      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 300,
            width: 200,
            child: ProductCard(product: longNameProduct),
          ),
        ),
      );

      // The text widget should exist with maxLines set
      final textWidget = tester.widget<Text>(
        find.text(longNameProduct.name),
      );
      expect(textWidget.maxLines, 2);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
