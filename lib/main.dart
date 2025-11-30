import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/router.dart';

void main() {
  usePathUrlStrategy();
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
    return MaterialApp.router(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      routerConfig: router,
    );
  }
}
