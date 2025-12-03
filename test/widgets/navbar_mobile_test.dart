import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/navbar_mobile.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('MobileMenuItem Widget Tests', () {
    testWidgets('displays icon and label', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const MobileMenuItem(
            icon: Icons.home,
            label: 'Home',
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('calls onTap callback when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        wrapWidget(
          MobileMenuItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Home'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('has InkWell for tap feedback', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const MobileMenuItem(
            icon: Icons.home,
            label: 'Home',
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
    });
  });

  group('MobileMenuExpandableItem Widget Tests', () {
    testWidgets('displays icon and label', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const MobileMenuExpandableItem(
            icon: Icons.shopping_bag,
            label: 'Shop',
            isExpanded: false,
          ),
        ),
      );

      expect(find.byIcon(Icons.shopping_bag), findsOneWidget);
      expect(find.text('Shop'), findsOneWidget);
    });

    testWidgets('shows expand_more icon when collapsed', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const MobileMenuExpandableItem(
            icon: Icons.shopping_bag,
            label: 'Shop',
            isExpanded: false,
          ),
        ),
      );

      expect(find.byIcon(Icons.expand_more), findsOneWidget);
      expect(find.byIcon(Icons.expand_less), findsNothing);
    });

    testWidgets('shows expand_less icon when expanded', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const MobileMenuExpandableItem(
            icon: Icons.shopping_bag,
            label: 'Shop',
            isExpanded: true,
          ),
        ),
      );

      expect(find.byIcon(Icons.expand_less), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsNothing);
    });

    testWidgets('calls onTap callback when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        wrapWidget(
          MobileMenuExpandableItem(
            icon: Icons.shopping_bag,
            label: 'Shop',
            isExpanded: false,
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Shop'));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });

  group('MobileMenuSubItem Widget Tests', () {
    testWidgets('displays label', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const MobileMenuSubItem(label: 'Sub Item'),
        ),
      );

      expect(find.text('Sub Item'), findsOneWidget);
    });

    testWidgets('calls onTap callback when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        wrapWidget(
          MobileMenuSubItem(
            label: 'Sub Item',
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Sub Item'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('has InkWell for tap feedback', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const MobileMenuSubItem(label: 'Sub Item'),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
    });
  });

  group('MobileMenuContainer Widget Tests', () {
    testWidgets('displays Home menu item', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithProvidersScrollable(
          const MobileMenuContainer(),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('displays Sale menu item', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithProvidersScrollable(
          const MobileMenuContainer(),
        ),
      );

      expect(find.text('Sale'), findsOneWidget);
    });

    testWidgets('displays About menu item', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithProvidersScrollable(
          const MobileMenuContainer(),
        ),
      );

      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('displays Shop expandable section', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithProvidersScrollable(
          const MobileMenuContainer(),
        ),
      );

      expect(find.text('Shop'), findsOneWidget);
    });

    testWidgets('displays The Print Shack expandable section', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithProvidersScrollable(
          const MobileMenuContainer(),
        ),
      );

      expect(find.text('The Print Shack'), findsOneWidget);
    });

    testWidgets('displays Login when not authenticated', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithProvidersScrollable(
          const MobileMenuContainer(),
        ),
      );

      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('calls onHomeTap when Home is tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        wrapWidgetWithProvidersScrollable(
          MobileMenuContainer(onHomeTap: () => tapped = true),
        ),
      );

      await tester.tap(find.text('Home'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('expands Shop section when tapped', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithProvidersScrollable(
          const MobileMenuContainer(),
        ),
      );

      // Initially collapsed - should show expand_more
      expect(find.byIcon(Icons.expand_more), findsNWidgets(2));

      // Tap Shop to expand
      await tester.tap(find.text('Shop'));
      await tester.pumpAndSettle();

      // Should now show collection items
      expect(find.text('Essentials'), findsOneWidget);
    });

    testWidgets('expands Print Shack section when tapped', (tester) async {
      await tester.pumpWidget(
        wrapWidgetWithProvidersScrollable(
          const MobileMenuContainer(),
        ),
      );

      // Tap Print Shack to expand
      await tester.tap(find.text('The Print Shack'));
      await tester.pumpAndSettle();

      // Should show sub-items
      expect(find.text('Personalise'), findsOneWidget);
    });
  });
}
