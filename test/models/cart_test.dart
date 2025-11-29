import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';

void main() {
  final testProduct = Product(
    id: 'test-1',
    name: 'Test Product',
    price: 10.00,
    imageUrl: 'https://example.com/image.jpg',
    description: 'A test product',
    category: ProductCategory.merchandise,
  );

  final discountedProduct = Product(
    id: 'test-2',
    name: 'Discounted Product',
    price: 20.00,
    discountedPrice: 15.00,
    imageUrl: 'https://example.com/image.jpg',
    description: 'A discounted product',
    category: ProductCategory.product,
  );

  group('CartItem', () {
    test('calculates totalPrice correctly', () {
      final item = CartItem(product: testProduct, quantity: 3);
      expect(item.totalPrice, 30.00);
    });

    test('uses discountedPrice when available', () {
      final item = CartItem(product: discountedProduct, quantity: 2);
      expect(item.totalPrice, 30.00); // 15.00 * 2
    });

    test('generates unique key without variants', () {
      final item = CartItem(product: testProduct, quantity: 1);
      expect(item.uniqueKey, 'test-1__');
    });

    test('generates unique key with color and size', () {
      final item = CartItem(
        product: testProduct,
        quantity: 1,
        selectedColor: 'Red',
        selectedSize: 'M',
      );
      expect(item.uniqueKey, 'test-1_Red_M');
    });

    test('copyWith creates new instance with updated values', () {
      final item = CartItem(product: testProduct, quantity: 1);
      final updated = item.copyWith(quantity: 5);

      expect(updated.quantity, 5);
      expect(updated.product, testProduct);
    });

    test('equality based on product id and variants', () {
      final item1 = CartItem(
        product: testProduct,
        quantity: 1,
        selectedColor: 'Red',
      );
      final item2 = CartItem(
        product: testProduct,
        quantity: 5,
        selectedColor: 'Red',
      );

      expect(item1, equals(item2));
    });
  });

  group('CartProvider', () {
    late CartProvider cart;

    setUp(() {
      cart = CartProvider();
    });

    test('starts empty', () {
      expect(cart.isEmpty, true);
      expect(cart.itemCount, 0);
      expect(cart.totalPrice, 0.0);
    });

    test('addItem adds new item', () {
      cart.addItem(product: testProduct, quantity: 2);

      expect(cart.items.length, 1);
      expect(cart.itemCount, 2);
      expect(cart.totalPrice, 20.00);
    });

    test('addItem merges quantity for same product and variants', () {
      cart.addItem(product: testProduct, quantity: 2);
      cart.addItem(product: testProduct, quantity: 3);

      expect(cart.items.length, 1);
      expect(cart.itemCount, 5);
    });

    test('addItem keeps separate items for different variants', () {
      cart.addItem(product: testProduct, quantity: 1, selectedColor: 'Red');
      cart.addItem(product: testProduct, quantity: 1, selectedColor: 'Blue');

      expect(cart.items.length, 2);
      expect(cart.itemCount, 2);
    });

    test('removeItem removes item by uniqueKey', () {
      cart.addItem(product: testProduct, quantity: 1);
      final key = cart.items.first.uniqueKey;

      cart.removeItem(key);

      expect(cart.isEmpty, true);
    });

    test('updateQuantity changes item quantity', () {
      cart.addItem(product: testProduct, quantity: 1);
      final key = cart.items.first.uniqueKey;

      cart.updateQuantity(key, 5);

      expect(cart.items.first.quantity, 5);
    });

    test('updateQuantity removes item when quantity < 1', () {
      cart.addItem(product: testProduct, quantity: 2);
      final key = cart.items.first.uniqueKey;

      cart.updateQuantity(key, 0);

      expect(cart.isEmpty, true);
    });

    test('clear removes all items', () {
      cart.addItem(product: testProduct, quantity: 1);
      cart.addItem(product: discountedProduct, quantity: 2);

      cart.clear();

      expect(cart.isEmpty, true);
    });

    test('totalPrice sums all items correctly', () {
      cart.addItem(product: testProduct, quantity: 2); // 20.00
      cart.addItem(product: discountedProduct, quantity: 1); // 15.00

      expect(cart.totalPrice, 35.00);
    });
  });
}
