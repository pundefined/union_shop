import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/screens/about_page.dart';
import 'package:union_shop/screens/cart_page.dart';
import 'package:union_shop/screens/checkout_page.dart';
import 'package:union_shop/screens/collection_page.dart';
import 'package:union_shop/screens/collections_page.dart';
import 'package:union_shop/screens/home.dart';
import 'package:union_shop/screens/login_signup_screen.dart';
import 'package:union_shop/screens/print_shack_about_page.dart';
import 'package:union_shop/screens/print_shack_form_page.dart';
import 'package:union_shop/screens/product_page.dart';
import 'package:union_shop/widgets/app_shell.dart';

/// Application router configuration using go_router.
///
/// Uses ShellRoute to wrap all routes with AppShell for consistent
/// navigation bar and footer across all pages.
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutPage(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginSignupScreen(),
        ),
        GoRoute(
          path: '/checkout',
          builder: (context, state) => const CheckoutPage(),
        ),
        GoRoute(
          path: '/print-shack',
          builder: (context, state) => const PrintShackFormPage(),
        ),
        GoRoute(
          path: '/print-shack/about',
          builder: (context, state) => const PrintShackAboutPage(),
        ),
        GoRoute(
          path: '/collections',
          builder: (context, state) => const CollectionsPage(),
          routes: [
            GoRoute(
              path: ':collectionSlug',
              builder: (context, state) {
                final slug = state.pathParameters['collectionSlug']!;
                final collection =
                    Collection.findBySlug(sampleCollections, slug);
                if (collection == null) {
                  throw Exception('Collection not found: $slug');
                }
                return CollectionPage(collection: collection);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/products/:productSlug',
          builder: (context, state) {
            final slug = state.pathParameters['productSlug']!;
            // Search all collections for the product
            for (final collection in sampleCollections) {
              final product = Product.findBySlug(collection.items, slug);
              if (product != null) {
                return ProductPage(product: product);
              }
            }
            throw Exception('Product not found: $slug');
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    return AppShell(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  },
);
