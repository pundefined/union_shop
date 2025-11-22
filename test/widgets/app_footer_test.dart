import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/app_footer.dart';

void main() {
  testWidgets('AppFooter renders opening hours and clickable items',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: AppFooter())));

    // Verify heading and some expected lines are present
    expect(find.text('Opening Hours'), findsOneWidget);
    expect(find.text('Purchase online 24/7'), findsOneWidget);

    // Verify clickable items exist
    final searchFinder = find.text('Search');
    final termsFinder = find.text('Terms & Conditions of Sale Policy');

    expect(searchFinder, findsOneWidget);
    expect(termsFinder, findsOneWidget);

    // Tap the clickable items to ensure they're tappable and do not throw
    await tester.tap(searchFinder);
    await tester.pump();

    await tester.tap(termsFinder);
    await tester.pump();
  });
}
