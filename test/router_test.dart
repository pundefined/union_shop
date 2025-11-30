import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/router.dart';

void main() {
  group('Router configuration', () {
    test('router is configured with initial location /', () {
      expect(router.routeInformationProvider.value.uri.path, equals('/'));
    });

    test('router has routes for all main pages', () {
      // Get route names from the configuration
      final routes = router.configuration.routes;

      // Should have a ShellRoute as the top-level route
      expect(routes.length, equals(1));

      // The ShellRoute should contain child routes
      final shellRoute = routes.first;
      expect(shellRoute.routes.isNotEmpty, isTrue);
    });

    test('router matches / path', () {
      final match = router.configuration.findMatch(Uri.parse('/'));
      expect(match.uri.path, equals('/'));
    });

    test('router matches /about path', () {
      final match = router.configuration.findMatch(Uri.parse('/about'));
      expect(match.uri.path, equals('/about'));
    });

    test('router matches /collections path', () {
      final match = router.configuration.findMatch(Uri.parse('/collections'));
      expect(match.uri.path, equals('/collections'));
    });

    test('router matches /collections/:slug path', () {
      final match =
          router.configuration.findMatch(Uri.parse('/collections/summer-sale'));
      expect(match.uri.path, equals('/collections/summer-sale'));
      expect(match.pathParameters['collectionSlug'], equals('summer-sale'));
    });

    test('router matches /collections/:slug/products/:slug path', () {
      final match = router.configuration.findMatch(
          Uri.parse('/collections/summer-sale/products/test-product'));
      expect(match.uri.path,
          equals('/collections/summer-sale/products/test-product'));
      expect(match.pathParameters['collectionSlug'], equals('summer-sale'));
      expect(match.pathParameters['productSlug'], equals('test-product'));
    });

    test('router matches /cart path', () {
      final match = router.configuration.findMatch(Uri.parse('/cart'));
      expect(match.uri.path, equals('/cart'));
    });

    test('router matches /checkout path', () {
      final match = router.configuration.findMatch(Uri.parse('/checkout'));
      expect(match.uri.path, equals('/checkout'));
    });

    test('router matches /login path', () {
      final match = router.configuration.findMatch(Uri.parse('/login'));
      expect(match.uri.path, equals('/login'));
    });

    test('router matches /print-shack path', () {
      final match = router.configuration.findMatch(Uri.parse('/print-shack'));
      expect(match.uri.path, equals('/print-shack'));
    });

    test('router matches /print-shack/about path', () {
      final match =
          router.configuration.findMatch(Uri.parse('/print-shack/about'));
      expect(match.uri.path, equals('/print-shack/about'));
    });
  });
}
