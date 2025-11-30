import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';

void main() {
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
