import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('About Page Tests', () {
    testWidgets('navigates to /about and shows content', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // The About button should be present in the navbar
      final aboutFinder = find.text('About');
      expect(aboutFinder, findsOneWidget);

      // Tap the About button to navigate
      await tester.tap(aboutFinder);
      await tester.pumpAndSettle();

      // Verify the About page title is shown and at least one paragraph
      expect(find.text('About us'), findsOneWidget);
      expect(
        find.textContaining('Welcome to the Union Shop!'),
        findsOneWidget,
      );
    });
  });
}
