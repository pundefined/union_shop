import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Product.findBySlug', () {
    final testProducts = [
      Product(
        id: '1',
        name: 'Portsmouth Magnet',
        price: 2.50,
        imageUrl: 'https://example.com/magnet.jpg',
        description: 'A magnet',
        category: ProductCategory.merchandise,
      ),
      Product(
        id: '2',
        name: 'University Hoodie',
        price: 25.00,
        imageUrl: 'https://example.com/hoodie.jpg',
        description: 'A hoodie',
        category: ProductCategory.product,
      ),
      Product(
        id: '3',
        name: 'UPSU Mug',
        price: 8.99,
        imageUrl: 'https://example.com/mug.jpg',
        description: 'A mug',
        category: ProductCategory.merchandise,
      ),
    ];

    test('finds product by existing slug', () {
      final result = Product.findBySlug(testProducts, 'portsmouth-magnet');

      expect(result, isNotNull);
      expect(result!.id, equals('1'));
      expect(result.name, equals('Portsmouth Magnet'));
    });

    test('returns null for non-existent slug', () {
      final result = Product.findBySlug(testProducts, 'non-existent');

      expect(result, isNull);
    });

    test('returns null for empty product list', () {
      final result = Product.findBySlug([], 'portsmouth-magnet');

      expect(result, isNull);
    });

    test('finds product with hyphenated slug', () {
      final result = Product.findBySlug(testProducts, 'university-hoodie');

      expect(result, isNotNull);
      expect(result!.id, equals('2'));
    });

    test('is case-sensitive for slug matching', () {
      final result = Product.findBySlug(testProducts, 'Portsmouth-Magnet');

      expect(result, isNull);
    });

    test('uses custom slug when provided', () {
      final products = [
        Product(
          id: '1',
          name: 'Portsmouth Magnet',
          price: 2.50,
          imageUrl: 'https://example.com/magnet.jpg',
          description: 'A magnet',
          category: ProductCategory.merchandise,
          slug: 'custom-magnet',
        ),
      ];

      final result = Product.findBySlug(products, 'custom-magnet');

      expect(result, isNotNull);
      expect(result!.id, equals('1'));
    });
  });
}
