import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/auth_provider.dart';
import 'package:union_shop/widgets/app_navbar.dart';

import '../helpers/mock_auth_service.dart';

void main() {
  group('AppNavbar', () {
    late MockAuthService mockAuthService;
    late AuthProvider authProvider;

    setUp(() {
      mockAuthService = MockAuthService();
      authProvider = AuthProvider(authService: mockAuthService);
    });

    tearDown(() {
      authProvider.dispose();
      mockAuthService.dispose();
    });

    Widget wrapWithAuthProvider(Widget child) {
      return ChangeNotifierProvider<AuthProvider>.value(
        value: authProvider,
        child: MaterialApp(
          home: Scaffold(body: child),
        ),
      );
    }

    testWidgets('renders promotional banner', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithAuthProvider(const AppNavbar()),
      );

      expect(
        find.textContaining('BIG SALE!'),
        findsOneWidget,
      );
    });

    testWidgets('renders logo image', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithAuthProvider(const AppNavbar()),
      );

      expect(find.byType(ImageNetworkLogo), findsOneWidget);
    });

    testWidgets('renders search, account, and cart icons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithAuthProvider(const AppNavbar()),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });

    testWidgets('calls onSearch when search icon is tapped',
        (WidgetTester tester) async {
      bool searchTapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: MaterialApp(
            home: Scaffold(
              body: AppNavbar(
                onSearch: () => searchTapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();

      expect(searchTapped, isTrue);
    });

    testWidgets('calls onAccount when account icon is tapped',
        (WidgetTester tester) async {
      bool accountTapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: MaterialApp(
            home: Scaffold(
              body: AppNavbar(
                onAccount: () => accountTapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pump();

      expect(accountTapped, isTrue);
    });

    testWidgets('calls onCart when cart icon is tapped',
        (WidgetTester tester) async {
      bool cartTapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: MaterialApp(
            home: Scaffold(
              body: AppNavbar(
                onCart: () => cartTapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      await tester.pump();

      expect(cartTapped, isTrue);
    });

    testWidgets('calls onLogoTap when logo is tapped',
        (WidgetTester tester) async {
      bool logoTapped = false;

      // Set a larger screen size to ensure logo is visible
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: MaterialApp(
            home: Scaffold(
              body: AppNavbar(
                onLogoTap: () => logoTapped = true,
              ),
            ),
          ),
        ),
      );

      // Find the InkWell that wraps the logo and trigger its onTap callback
      final logoInkWell = find.ancestor(
        of: find.byType(ImageNetworkLogo),
        matching: find.byType(InkWell),
      );
      final inkWellWidget = tester.widget<InkWell>(logoInkWell);
      inkWellWidget.onTap?.call();

      expect(logoTapped, isTrue);

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });
  });

  group('AppNavbar - Mobile view', () {
    late MockAuthService mockAuthService;
    late AuthProvider authProvider;

    setUp(() {
      mockAuthService = MockAuthService();
      authProvider = AuthProvider(authService: mockAuthService);
    });

    tearDown(() {
      authProvider.dispose();
      mockAuthService.dispose();
    });

    testWidgets('shows hamburger menu on mobile screen size',
        (WidgetTester tester) async {
      // Set mobile screen size (less than 600)
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: const MaterialApp(
            home: Scaffold(body: AppNavbar()),
          ),
        ),
      );

      expect(find.byIcon(Icons.menu), findsOneWidget);

      // Reset screen size
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    testWidgets('hides horizontal nav links on mobile screen size',
        (WidgetTester tester) async {
      // Set mobile screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: const MaterialApp(
            home: Scaffold(body: AppNavbar()),
          ),
        ),
      );

      // NavLink widgets should not be present on mobile
      expect(find.byType(NavLink), findsNothing);

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    testWidgets('toggles mobile menu when hamburger icon is tapped',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: const MaterialApp(
            home: Scaffold(body: AppNavbar()),
          ),
        ),
      );

      // Mobile menu should not be visible initially
      expect(find.byType(MobileMenuContainer), findsNothing);

      // Tap hamburger menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();

      // Mobile menu should now be visible
      expect(find.byType(MobileMenuContainer), findsOneWidget);

      // Tap hamburger menu again to close
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();

      // Mobile menu should be hidden again
      expect(find.byType(MobileMenuContainer), findsNothing);

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });
  });

  group('AppNavbar - Desktop view', () {
    late MockAuthService mockAuthService;
    late AuthProvider authProvider;

    setUp(() {
      mockAuthService = MockAuthService();
      authProvider = AuthProvider(authService: mockAuthService);
    });

    tearDown(() {
      authProvider.dispose();
      mockAuthService.dispose();
    });

    testWidgets('shows horizontal nav links on desktop screen size',
        (WidgetTester tester) async {
      // Set desktop screen size (900 or more)
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: const MaterialApp(
            home: Scaffold(body: AppNavbar()),
          ),
        ),
      );

      // NavLink widgets should be present on desktop (Home, Sale, About)
      // Shop and Print Shack are dropdowns, not NavLinks
      expect(find.byType(NavLink), findsNWidgets(3));

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    testWidgets('hides hamburger menu on desktop screen size',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: const MaterialApp(
            home: Scaffold(body: AppNavbar()),
          ),
        ),
      );

      expect(find.byIcon(Icons.menu), findsNothing);

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    testWidgets('displays all navigation labels on desktop',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: const MaterialApp(
            home: Scaffold(body: AppNavbar()),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Sale'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(find.text('Shop'), findsOneWidget); // Shop dropdown
      expect(find.text('Print Shack'), findsOneWidget); // Print Shack dropdown

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });
  });

  group('MobileMenuContainer', () {
    late MockAuthService mockAuthService;
    late AuthProvider authProvider;

    setUp(() {
      mockAuthService = MockAuthService();
      authProvider = AuthProvider(authService: mockAuthService);
    });

    tearDown(() {
      authProvider.dispose();
      mockAuthService.dispose();
    });

    Widget wrapWithAuthProvider(Widget child) {
      return ChangeNotifierProvider<AuthProvider>.value(
        value: authProvider,
        child: MaterialApp(
          home: Scaffold(body: child),
        ),
      );
    }

    testWidgets('renders all menu items', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithAuthProvider(const MobileMenuContainer()),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Sale'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('renders menu icons', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithAuthProvider(const MobileMenuContainer()),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.local_offer), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('calls onHomeTap when Home is tapped',
        (WidgetTester tester) async {
      bool homeTapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: MaterialApp(
            home: Scaffold(
              body: MobileMenuContainer(
                onHomeTap: () => homeTapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Home'));
      await tester.pump();

      expect(homeTapped, isTrue);
    });

    testWidgets('calls onSaleTap when Sale is tapped',
        (WidgetTester tester) async {
      bool saleTapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: MaterialApp(
            home: Scaffold(
              body: MobileMenuContainer(
                onSaleTap: () => saleTapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Sale'));
      await tester.pump();

      expect(saleTapped, isTrue);
    });

    testWidgets('calls onAboutTap when About is tapped',
        (WidgetTester tester) async {
      bool aboutTapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: MaterialApp(
            home: Scaffold(
              body: MobileMenuContainer(
                onAboutTap: () => aboutTapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('About'));
      await tester.pump();

      expect(aboutTapped, isTrue);
    });

    testWidgets('calls onLoginTap when Login is tapped (unauthenticated)',
        (WidgetTester tester) async {
      bool loginTapped = false;

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: MaterialApp(
            home: Scaffold(
              body: MobileMenuContainer(
                onLoginTap: () => loginTapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(loginTapped, isTrue);
    });
  });

  group('NavLink', () {
    testWidgets('renders text correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                NavLink(
                  label: 'Test Label',
                  text: 'Test Text',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Test Text'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                NavLink(
                  label: 'Test',
                  text: 'Test',
                  onPressed: () => pressed = true,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('has semantic label for accessibility',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                NavLink(
                  label: 'Navigation Link',
                  text: 'Link',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Check that Semantics widget exists with the correct label
      final semanticsWidget = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics && widget.properties.label == 'Navigation Link',
      );
      expect(semanticsWidget, findsOneWidget);
    });
  });

  group('ImageNetworkLogo', () {
    testWidgets('renders Image.network widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ImageNetworkLogo()),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });
  });
}
