import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/widgets/search_overlay.dart';

void main() {
  group('SearchOverlay Tests', () {
    late bool closeCalled;
    late String? navigatedRoute;

    Widget createTestWidget() {
      closeCalled = false;
      navigatedRoute = null;

      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: SearchOverlay(
                onClose: () => closeCalled = true,
              ),
            ),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) {
              navigatedRoute = state.uri.toString();
              return const Scaffold(body: Text('Search Page'));
            },
          ),
        ],
      );

      return MaterialApp.router(
        routerConfig: router,
      );
    }

    testWidgets('displays search input field', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search products...'), findsOneWidget);
    });

    testWidgets('displays submit button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('displays close button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('calls onClose when close button tapped', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(closeCalled, isTrue);
    });

    testWidgets('navigates to search page on submit with query',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'hoodie');
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();

      expect(navigatedRoute, equals('/search?q=hoodie'));
      expect(closeCalled, isTrue);
    });

    testWidgets('navigates to search page on submit with empty query',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();

      expect(navigatedRoute, equals('/search'));
      expect(closeCalled, isTrue);
    });

    testWidgets('submits search on keyboard enter', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'shirt');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();

      expect(navigatedRoute, equals('/search?q=shirt'));
      expect(closeCalled, isTrue);
    });

    testWidgets('auto-focuses text field on open', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump(); // Allow postFrameCallback to run

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.focusNode?.hasFocus, isTrue);
    });

    testWidgets('encodes special characters in query', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'blue & white');
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();

      // Uri.encodeQueryComponent uses + for spaces
      expect(navigatedRoute, equals('/search?q=blue+%26+white'));
    });
  });
}
