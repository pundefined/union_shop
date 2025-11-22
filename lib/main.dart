import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/screens/about_page.dart';
import 'package:union_shop/widgets/app_shell.dart';
import 'package:union_shop/home.dart';

void main() {
  runApp(const UnionShopApp());
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
      // Use named routes and wrap pages in AppShell so the shared shell can
      // be controlled centrally. For the incremental refactor we keep the
      // existing in-page headers by disabling the shell navbar (showNavbar:
      // false). After migrating pages to remove their embedded header we
      // will enable the shell navbar.
      initialRoute: '/',
      routes: {
        // Wrap pages in AppShell so the navbar is shared. Pages have been
        // refactored to provide only their body content (no header/scaffold),
        // so the shell's navbar is enabled here.
        '/': (context) => const AppShell(child: HomeScreen()),
        '/about': (context) => const AppShell(child: AboutPage()),
        '/product': (context) => const AppShell(child: ProductPage()),
      },
    );
  }
}
