import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/utils/slug.dart';

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
}
