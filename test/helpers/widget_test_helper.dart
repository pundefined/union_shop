import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/auth_provider.dart';
import 'package:union_shop/models/cart.dart';

import 'mock_auth_service.dart';

/// Simple wrapper for widget tests - just MaterialApp + Scaffold.
/// Use this for true widget unit tests.
Widget wrapWidget(Widget child) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}

/// Wrapper with scrolling for widgets that expect to be in a scroll context.
Widget wrapWidgetScrollable(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(child: child),
    ),
  );
}

/// Wrapper with providers for widgets that consume Provider state (like AuthProvider).
/// Uses MockAuthService to avoid Firebase dependency.
Widget wrapWidgetWithProviders(Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(authService: MockAuthService()),
      ),
    ],
    child: MaterialApp(
      home: Scaffold(body: child),
    ),
  );
}

/// Wrapper with providers and scrolling for widgets that need both.
Widget wrapWidgetWithProvidersScrollable(Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(authService: MockAuthService()),
      ),
    ],
    child: MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(child: child),
      ),
    ),
  );
}

/// Wrapper with CartProvider for widgets that need cart state.
/// Optionally accepts an existing CartProvider for pre-populated carts.
Widget wrapWidgetWithCart(Widget child, {CartProvider? cart}) {
  return ChangeNotifierProvider<CartProvider>(
    create: (_) => cart ?? CartProvider(),
    child: MaterialApp(
      home: Scaffold(body: child),
    ),
  );
}

/// Wrapper with CartProvider and scrolling.
Widget wrapWidgetWithCartScrollable(Widget child, {CartProvider? cart}) {
  return ChangeNotifierProvider<CartProvider>(
    create: (_) => cart ?? CartProvider(),
    child: MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(child: child),
      ),
    ),
  );
}

/// Standard test viewport sizes for responsive testing.
class TestViewportSizes {
  static const Size mobile = Size(400, 800);
  static const Size tablet = Size(768, 1024);
  static const Size desktop = Size(1280, 800);
  static const Size largeDesktop = Size(1920, 1080);
}

/// Extension to easily set viewport size in tests.
extension WidgetTesterViewport on WidgetTester {
  Future<void> setViewportSize(Size size) async {
    await binding.setSurfaceSize(size);
    view.physicalSize = size;
    view.devicePixelRatio = 1.0;
  }

  Future<void> resetViewportSize() async {
    await binding.setSurfaceSize(null);
    view.resetPhysicalSize();
    view.resetDevicePixelRatio();
  }
}
