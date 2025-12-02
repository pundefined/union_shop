import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/screens/checkout_page.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('CheckoutPage Widget Tests', () {
    final testProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      price: 10.00,
      imageUrl: 'assets/images/mug.png',
      description: 'A test product',
      category: ProductCategory.merchandise,
    );

    final testProductWithVariants = Product(
      id: 'test-2',
      name: 'Variant Product',
      price: 25.00,
      imageUrl: 'assets/images/basic_tshirt.png',
      description: 'A product with variants',
      category: ProductCategory.merchandise,
      colors: ['Red', 'Blue'],
      sizes: ['S', 'M', 'L'],
    );

    testWidgets('shows empty cart message when cart is empty', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithCart(const CheckoutPage()),
      );
      await tester.pump();

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('Continue Shopping'), findsOneWidget);
    });

    testWidgets('Continue Shopping button has tap handler', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithCart(const CheckoutPage()),
      );
      await tester.pump();

      // Find the ElevatedButton and verify it has an onPressed handler
      final button = find.widgetWithText(ElevatedButton, 'Continue Shopping');
      expect(button, findsOneWidget);

      final buttonWidget = tester.widget<ElevatedButton>(button);
      expect(buttonWidget.onPressed, isNotNull);
    });

    testWidgets('shows order summary header with item count', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 2);

      await tester.pumpWidget(
        wrapWidgetWithCart(const CheckoutPage(), cart: cart),
      );
      await tester.pump();

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('2 items'), findsOneWidget);
    });

    testWidgets('shows singular item text for one item', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(
        wrapWidgetWithCart(const CheckoutPage(), cart: cart),
      );
      await tester.pump();

      expect(find.text('1 item'), findsOneWidget);
    });

    testWidgets('displays cart item details', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 3);

      await tester.pumpWidget(
        wrapWidgetWithCart(const CheckoutPage(), cart: cart),
      );
      await tester.pump();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Qty: 3'), findsOneWidget);
      // Price appears twice: once for item total, once for order total
      expect(find.text('£30.00'), findsNWidgets(2));
    });

    testWidgets('displays variant information when present', (tester) async {
      final cart = CartProvider();
      cart.addItem(
        product: testProductWithVariants,
        quantity: 1,
        selectedColor: 'Red',
        selectedSize: 'M',
      );

      await tester.pumpWidget(
        wrapWidgetWithCart(const CheckoutPage(), cart: cart),
      );
      await tester.pump();

      expect(find.text('Red / M'), findsOneWidget);
    });

    testWidgets('shows correct total price', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 2);

      await tester.pumpWidget(
        wrapWidgetWithCart(const CheckoutPage(), cart: cart),
      );
      await tester.pump();

      expect(find.text('Total'), findsOneWidget);
      // Price appears twice: once for item total, once for order total
      expect(find.text('£20.00'), findsNWidgets(2));
    });

    testWidgets('shows Place Order button with tap handler', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(
        wrapWidgetWithCart(const CheckoutPage(), cart: cart),
      );
      await tester.pump();

      // Find the Place Order button and verify it has an onPressed handler
      final button = find.widgetWithText(ElevatedButton, 'Place Order');
      expect(button, findsOneWidget);

      final buttonWidget = tester.widget<ElevatedButton>(button);
      expect(buttonWidget.onPressed, isNotNull);
    });
  });
}
