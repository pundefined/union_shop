import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/app_shell.dart';

void main() {
  group('ProductPage Widget', () {
    final testProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      price: 19.99,
      imageUrl: 'https://example.com/image.jpg',
      description: 'Test product description',
      discountedPrice: 14.99,
      colors: ['Red', 'Blue'],
      sizes: ['S', 'M', 'L'],
    );

    // Helper widget to wrap ProductPage in AppShell for realistic testing
    Widget wrapInAppShell(Widget child) {
      return MaterialApp(
        home: AppShell(child: child),
      );
    }

    testWidgets('displays product name', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: testProduct)),
      );

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('displays product price', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: testProduct)),
      );

      expect(find.text('£19.99'), findsOneWidget);
    });

    testWidgets('displays discounted price when available',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: testProduct)),
      );

      expect(find.text('£14.99'), findsOneWidget);
    });

    testWidgets('displays product description', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: testProduct)),
      );

      expect(find.text('Test product description'), findsOneWidget);
    });

    testWidgets('displays color selector when product has colours',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: testProduct)),
      );

      expect(find.text('Colour'), findsOneWidget);
    });

    testWidgets('does not display color selector when product has no colours',
        (WidgetTester tester) async {
      final productNoColours = Product(
        id: 'test-2',
        name: 'No Colour Product',
        price: 9.99,
        imageUrl: 'https://example.com/image.jpg',
        description: 'Test product',
      );

      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: productNoColours)),
      );

      expect(find.text('Colour'), findsNothing);
    });

    testWidgets('displays size selector when product has sizes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: testProduct)),
      );

      expect(find.text('Size'), findsOneWidget);
    });

    testWidgets('does not display size selector when product has no sizes',
        (WidgetTester tester) async {
      final productNoSizes = Product(
        id: 'test-3',
        name: 'No Size Product',
        price: 9.99,
        imageUrl: 'https://example.com/image.jpg',
        description: 'Test product',
      );

      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: productNoSizes)),
      );

      expect(find.text('Size'), findsNothing);
    });

    testWidgets('displays quantity selector', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: testProduct)),
      );

      expect(find.text('Quantity'), findsOneWidget);
    });

    testWidgets('displays Add to Cart button', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: testProduct)),
      );

      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('displays product image', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapInAppShell(ProductPage(product: testProduct)),
      );

      // Check that Image.network is in the widget tree (there will be 2: navbar logo + product image)
      expect(find.byType(Image), findsWidgets);
      // Verify the product image URL is present
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is NetworkImage &&
              (widget.image as NetworkImage).url ==
                  'https://example.com/image.jpg',
        ),
        findsOneWidget,
      );
    });
  });
}
