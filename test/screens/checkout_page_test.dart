import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/screens/checkout_page.dart';
import 'package:union_shop/widgets/app_shell.dart';

/// Creates a test widget wrapped in AppShell with CartProvider and routing.
Widget createTestApp({
  required Widget child,
  CartProvider? cartProvider,
}) {
  return ChangeNotifierProvider<CartProvider>(
    create: (_) => cartProvider ?? CartProvider(),
    child: MaterialApp(
      home: AppShell(child: child),
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(body: Text('Home Page')),
          );
        }
        return null;
      },
    ),
  );
}

void main() {
  group('Checkout Page Tests', () {
    final testProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      price: 10.00,
      imageUrl: 'https://example.com/image.jpg',
      description: 'A test product',
      category: ProductCategory.merchandise,
    );

    final testProductWithVariants = Product(
      id: 'test-2',
      name: 'Variant Product',
      price: 25.00,
      imageUrl: 'https://example.com/image2.jpg',
      description: 'A product with variants',
      category: ProductCategory.merchandise,
      colors: ['Red', 'Blue'],
      sizes: ['S', 'M', 'L'],
    );

    testWidgets('shows empty cart message when cart is empty', (tester) async {
      await tester.pumpWidget(createTestApp(child: const CheckoutPage()));
      await tester.pump();

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('Continue Shopping'), findsOneWidget);
    });

    testWidgets('shows order summary header with item count', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 2);

      await tester.pumpWidget(
        createTestApp(child: const CheckoutPage(), cartProvider: cart),
      );
      await tester.pump();

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('2 items'), findsOneWidget);
    });

    testWidgets('shows singular item text for one item', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(
        createTestApp(child: const CheckoutPage(), cartProvider: cart),
      );
      await tester.pump();

      expect(find.text('1 item'), findsOneWidget);
    });

    testWidgets('displays cart item details', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 3);

      await tester.pumpWidget(
        createTestApp(child: const CheckoutPage(), cartProvider: cart),
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
        createTestApp(child: const CheckoutPage(), cartProvider: cart),
      );
      await tester.pump();

      expect(find.text('Red / M'), findsOneWidget);
    });

    testWidgets('shows correct total price', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 2);

      await tester.pumpWidget(
        createTestApp(child: const CheckoutPage(), cartProvider: cart),
      );
      await tester.pump();

      expect(find.text('Total'), findsOneWidget);
      // Price appears twice: once for item total, once for order total
      expect(find.text('£20.00'), findsNWidgets(2));
    });

    testWidgets('shows Place Order button', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(
        createTestApp(child: const CheckoutPage(), cartProvider: cart),
      );
      await tester.pump();

      expect(find.text('Place Order'), findsOneWidget);
    });

    testWidgets('Place Order clears cart and shows snackbar', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(
        createTestApp(child: const CheckoutPage(), cartProvider: cart),
      );
      await tester.pump();

      expect(cart.isEmpty, isFalse);

      await tester.tap(find.text('Place Order'));
      await tester.pump();

      expect(cart.isEmpty, isTrue);
      expect(
        find.text('Order placed successfully! Thank you for your purchase.'),
        findsOneWidget,
      );
    });
  });
}
