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
  });

  group('Product slug uniqueness', () {
    test('products with same name generate same slug', () {
      final product1 = Product(
        id: '1',
        name: 'Test Product',
        price: 10.00,
        imageUrl: 'https://example.com/1.jpg',
        description: 'First product',
        category: ProductCategory.product,
      );

      final product2 = Product(
        id: '2',
        name: 'Test Product',
        price: 15.00,
        imageUrl: 'https://example.com/2.jpg',
        description: 'Second product',
        category: ProductCategory.product,
      );

      // Note: This test documents that auto-generated slugs may collide.
      // For global uniqueness, custom slugs should be provided or
      // a uniqueness check should be implemented at a higher level.
      expect(product1.slug, equals(product2.slug));
    });

    test('custom slugs can ensure uniqueness', () {
      final product1 = Product(
        id: '1',
        name: 'Test Product',
        price: 10.00,
        imageUrl: 'https://example.com/1.jpg',
        description: 'First product',
        category: ProductCategory.product,
        slug: 'test-product-1',
      );

      final product2 = Product(
        id: '2',
        name: 'Test Product',
        price: 15.00,
        imageUrl: 'https://example.com/2.jpg',
        description: 'Second product',
        category: ProductCategory.product,
        slug: 'test-product-2',
      );

      expect(product1.slug, isNot(equals(product2.slug)));
    });
  });
}
