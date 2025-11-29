import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/screens/cart_page.dart';
import 'package:union_shop/screens/product_page.dart';
import 'package:union_shop/screens/about_page.dart';
import 'package:union_shop/screens/collection_page.dart';
import 'package:union_shop/screens/collections_page.dart';
import 'package:union_shop/screens/login_signup_screen.dart';
import 'package:union_shop/screens/print_shack_form_page.dart';
import 'package:union_shop/widgets/app_shell.dart';
import 'package:union_shop/screens/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const UnionShopApp(),
    ),
  );
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AppShell(child: HomeScreen()),
        '/about': (context) => const AppShell(child: AboutPage()),
        '/cart': (context) => const AppShell(child: CartPage()),
        '/collections': (context) => const AppShell(child: CollectionsPage()),
        '/login': (context) => const AppShell(child: LoginSignupScreen()),
        '/print-shack': (context) =>
            const AppShell(child: PrintShackFormPage()),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/collection') {
          final args = settings.arguments as Collection?;
          if (args != null) {
            return MaterialPageRoute(
              builder: (context) =>
                  AppShell(child: CollectionPage(collection: args)),
            );
          }
          // Fallback to sampleCollection if no arguments provided
          return MaterialPageRoute(
            builder: (context) => AppShell(
              child: CollectionPage(collection: sampleCollection),
            ),
          );
        }
        if (settings.name == '/product') {
          final args = settings.arguments as Product?;
          if (args != null) {
            return MaterialPageRoute(
              builder: (context) => AppShell(child: ProductPage(product: args)),
            );
          }
        }
        return null;
      },
    );
  }
}
