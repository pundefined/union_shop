import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/screens/product_page.dart';
import 'package:union_shop/models/product.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('ProductPage Widget Tests', () {
    // Use a valid asset path for test products
    final testProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      price: 19.99,
      imageUrl: 'assets/images/summer_carousel.png',
      description: 'Test product description',
      category: ProductCategory.product,
      discountedPrice: 14.99,
      colors: ['Red', 'Blue'],
      sizes: ['S', 'M', 'L'],
    );

    /// Helper to pump ProductPage widget
    Future<void> pumpProductPage(WidgetTester tester, Product product) async {
      await tester.setViewportSize(TestViewportSizes.desktop);
      await tester
          .pumpWidget(wrapWidgetScrollable(ProductPage(product: product)));
      await tester.pump();
    }

    testWidgets('displays product name', (WidgetTester tester) async {
      await pumpProductPage(tester, testProduct);

      expect(find.text('Test Product'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays product price', (WidgetTester tester) async {
      await pumpProductPage(tester, testProduct);

      expect(find.text('£19.99'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays discounted price when available',
        (WidgetTester tester) async {
      await pumpProductPage(tester, testProduct);

      expect(find.text('£14.99'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays product description', (WidgetTester tester) async {
      await pumpProductPage(tester, testProduct);

      expect(find.text('Test product description'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays color selector when product has colours',
        (WidgetTester tester) async {
      await pumpProductPage(tester, testProduct);

      expect(find.text('Colour'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('does not display color selector when product has no colours',
        (WidgetTester tester) async {
      final productNoColours = Product(
        id: 'test-2',
        name: 'No Colour Product',
        price: 9.99,
        imageUrl: 'assets/images/summer_carousel.png',
        description: 'Test product',
        category: ProductCategory.product,
      );

      await pumpProductPage(tester, productNoColours);

      expect(find.text('Colour'), findsNothing);

      await tester.resetViewportSize();
    });

    testWidgets('displays size selector when product has sizes',
        (WidgetTester tester) async {
      await pumpProductPage(tester, testProduct);

      expect(find.text('Size'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('does not display size selector when product has no sizes',
        (WidgetTester tester) async {
      final productNoSizes = Product(
        id: 'test-3',
        name: 'No Size Product',
        price: 9.99,
        imageUrl: 'assets/images/summer_carousel.png',
        description: 'Test product',
        category: ProductCategory.product,
      );

      await pumpProductPage(tester, productNoSizes);

      expect(find.text('Size'), findsNothing);

      await tester.resetViewportSize();
    });

    testWidgets('displays quantity selector', (WidgetTester tester) async {
      await pumpProductPage(tester, testProduct);

      expect(find.text('Quantity'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays Add to Cart button', (WidgetTester tester) async {
      await pumpProductPage(tester, testProduct);

      expect(find.text('Add to Cart'), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('displays product image', (WidgetTester tester) async {
      await pumpProductPage(tester, testProduct);

      // Check that Image is in the widget tree
      expect(find.byType(Image), findsWidgets);

      await tester.resetViewportSize();
    });
  });
}
