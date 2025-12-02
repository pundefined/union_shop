import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/screens/about_page.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('AboutPage Widget Tests', () {
    testWidgets('displays title and content', (tester) async {
      await tester.setViewportSize(TestViewportSizes.desktop);

      await tester.pumpWidget(wrapWidgetScrollable(const AboutPage()));
      await tester.pumpAndSettle();

      expect(find.text('About us'), findsOneWidget);
      expect(
        find.textContaining('Welcome to the Union Shop!'),
        findsOneWidget,
      );

      await tester.resetViewportSize();
    });
  });
}
