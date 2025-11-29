import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/screens/cart_page.dart';

void main() {
  group('Cart Page Tests', () {
    Widget createTestWidget({CartProvider? cartProvider}) {
      return ChangeNotifierProvider<CartProvider>(
        create: (_) => cartProvider ?? CartProvider(),
        child: const MaterialApp(home: Scaffold(body: CartPage())),
      );
    }

    final testProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      price: 10.00,
      imageUrl: 'https://example.com/image.jpg',
      description: 'A test product',
      category: ProductCategory.merchandise,
    );

    testWidgets('shows empty cart message when cart is empty', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets('shows cart items when cart has items', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 2);

      await tester.pumpWidget(createTestWidget(cartProvider: cart));
      await tester.pump();

      expect(find.text('Shopping Cart'), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('2 items'), findsOneWidget);
    });

    testWidgets('shows correct total price', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 3);

      await tester.pumpWidget(createTestWidget(cartProvider: cart));
      await tester.pump();

      expect(find.text('£30.00'), findsOneWidget);
    });

    testWidgets('shows Checkout button', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(createTestWidget(cartProvider: cart));
      await tester.pump();

      expect(find.text('Checkout'), findsOneWidget);
    });

    testWidgets('can remove item from cart', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(createTestWidget(cartProvider: cart));
      await tester.pump();

      expect(find.text('Test Product'), findsOneWidget);

      await tester.tap(find.text('Remove'));
      await tester.pump();

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('can increase item quantity', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(createTestWidget(cartProvider: cart));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('can decrease item quantity', (tester) async {
      final cart = CartProvider();
      cart.addItem(product: testProduct, quantity: 3);

      await tester.pumpWidget(createTestWidget(cartProvider: cart));
      await tester.pump();

      expect(find.text('3'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    });
  });
}
