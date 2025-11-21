import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/app_navbar.dart';

void main() {
  testWidgets(
      'AppNavbar shows logo and tapping it navigates home and clears history',
      (WidgetTester tester) async {
    // Build an app with named routes so we can create a navigation stack.
    final navigatorKey = GlobalKey<NavigatorState>();

    final app = MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        '/': (context) => const Scaffold(body: Center(child: Text('HOME'))),
        '/second': (context) =>
            const Scaffold(body: Center(child: Text('SECOND'))),
        '/third': (context) => const Scaffold(body: AppNavbar()),
      },
      initialRoute: '/',
    );

    await tester.pumpWidget(app);

    // Create navigation stack: push /second then /third (AppNavbar)
    // Use the navigator key to push routes reliably in tests.
    navigatorKey.currentState!.pushNamed('/second');
    await tester.pumpAndSettle();
    navigatorKey.currentState!.pushNamed('/third');
    await tester.pumpAndSettle();

    // Verify we're on the third page which contains the AppNavbar
    expect(find.byType(AppNavbar), findsOneWidget);

    // The logo is wrapped with semantics label 'Home'
    final logo = find.bySemanticsLabel('Home');
    expect(logo, findsOneWidget);

    // Tap the logo. Default behavior should navigate to '/' and clear history.
    await tester.tap(logo);
    await tester.pumpAndSettle();

    // After tapping logo we should see the HOME page and the navigator should
    // not be able to pop (history cleared).
    expect(find.text('HOME'), findsOneWidget);
    // Use navigator key to inspect state.
    expect(navigatorKey.currentState!.canPop(), isFalse);
  });
}
