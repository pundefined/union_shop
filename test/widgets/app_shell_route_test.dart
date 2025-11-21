import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/app_shell.dart';
import 'package:union_shop/widgets/app_navbar.dart';

void main() {
  testWidgets('AppShell wraps child and shows AppNavbar',
      (WidgetTester tester) async {
    const app = MaterialApp(
      home: AppShell(child: Text('CHILD-CONTENT')),
    );

    await tester.pumpWidget(app);

    // AppShell should show the child content and the shared AppNavbar
    expect(find.text('CHILD-CONTENT'), findsOneWidget);
    expect(find.byType(AppNavbar), findsOneWidget);
  });
}
