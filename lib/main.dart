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
      initialRoute: '/',
      routes: {
        '/': (context) => const AppShell(child: HomeScreen()),
        '/about': (context) => const AppShell(child: AboutPage()),
        '/product': (context) => const AppShell(child: ProductPage()),
      },
    );
  }
}
