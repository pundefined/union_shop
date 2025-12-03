import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/app_shell.dart';
import 'package:union_shop/widgets/app_navbar.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('AppShell Widget Tests', () {
    testWidgets('wraps child and displays AppNavbar',
        (WidgetTester tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetWithProviders(const AppShell(child: Text('CHILD-CONTENT'))),
      );
      await tester.pump();

      // AppShell should show the child content and the shared AppNavbar
      expect(find.text('CHILD-CONTENT'), findsOneWidget);
      expect(find.byType(AppNavbar), findsOneWidget);

      await tester.resetViewportSize();
    });

    testWidgets('child content is scrollable', (WidgetTester tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(
        wrapWidgetWithProviders(
          AppShell(
            child: Column(
              children: [
                const Text('TOP-CONTENT'),
                // Create content taller than the viewport
                for (int i = 0; i < 50; i++)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('Item $i'),
                  ),
                const Text('BOTTOM-CONTENT'),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      // Verify SingleChildScrollView is present
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Initially, TOP-CONTENT should be visible and BOTTOM-CONTENT should not
      expect(find.text('TOP-CONTENT'), findsOneWidget);
      expect(find.text('BOTTOM-CONTENT').hitTestable(), findsNothing);

      // Scroll down to reveal bottom content
      await tester.scrollUntilVisible(
        find.text('BOTTOM-CONTENT'),
        500,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      // Now BOTTOM-CONTENT should be visible
      expect(find.text('BOTTOM-CONTENT'), findsOneWidget);

      await tester.resetViewportSize();
    });
  });
}
