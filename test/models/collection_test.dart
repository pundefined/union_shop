import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';

void main() {
  group('generateSlug', () {
    test('converts to lowercase', () {
      expect(generateSlug('Summer Sale'), equals('summer-sale'));
    });

    test('replaces spaces with hyphens', () {
      expect(generateSlug('new arrivals'), equals('new-arrivals'));
    });

    test('removes special characters', () {
      expect(generateSlug('Sale! 50% Off'), equals('sale-50-off'));
    });

    test('removes consecutive hyphens', () {
      expect(generateSlug('Summer   Sale'), equals('summer-sale'));
    });

    test('trims hyphens from start and end', () {
      expect(generateSlug(' Summer Sale '), equals('summer-sale'));
    });

    test('handles already valid slugs', () {
      expect(generateSlug('summer-sale'), equals('summer-sale'));
    });

    test('handles empty string', () {
      expect(generateSlug(''), equals(''));
    });

    test('handles string with only special characters', () {
      expect(generateSlug('!@#\$%'), equals(''));
    });
  });

  group('Collection', () {
    test('auto-generates slug from title', () {
      final collection = Collection(
        id: 'test-1',
        title: 'Summer Sale',
        description: 'Test description',
        imageUrl: 'https://example.com/image.jpg',
        items: [],
      );

      expect(collection.slug, equals('summer-sale'));
    });

    test('uses provided slug when given', () {
      final collection = Collection(
        id: 'test-1',
        title: 'Summer Sale',
        description: 'Test description',
        imageUrl: 'https://example.com/image.jpg',
        items: [],
        slug: 'custom-slug',
      );

      expect(collection.slug, equals('custom-slug'));
    });

    test('generates URL-safe slug from complex title', () {
      final collection = Collection(
        id: 'test-1',
        title: 'New! Arrivals & More',
        description: 'Test description',
        imageUrl: 'https://example.com/image.jpg',
        items: [],
      );

      expect(collection.slug, equals('new-arrivals-more'));
    });
  });

  group('Collection.findBySlug', () {
    final testCollections = [
      Collection(
        id: '1',
        title: 'Summer Sale',
        description: 'Summer items',
        imageUrl: 'https://example.com/summer.jpg',
        items: [],
      ),
      Collection(
        id: '2',
        title: 'New Arrivals',
        description: 'New items',
        imageUrl: 'https://example.com/new.jpg',
        items: [],
      ),
      Collection(
        id: '3',
        title: 'Gift Ideas',
        description: 'Gift items',
        imageUrl: 'https://example.com/gifts.jpg',
        items: [],
      ),
    ];

    test('finds collection by existing slug', () {
      final result = Collection.findBySlug(testCollections, 'summer-sale');

      expect(result, isNotNull);
      expect(result!.id, equals('1'));
      expect(result.title, equals('Summer Sale'));
    });

    test('returns null for non-existent slug', () {
      final result = Collection.findBySlug(testCollections, 'non-existent');

      expect(result, isNull);
    });

    test('returns null for empty collection list', () {
      final result = Collection.findBySlug([], 'summer-sale');

      expect(result, isNull);
    });

    test('finds collection with hyphenated slug', () {
      final result = Collection.findBySlug(testCollections, 'new-arrivals');

      expect(result, isNotNull);
      expect(result!.id, equals('2'));
    });
  });
}
