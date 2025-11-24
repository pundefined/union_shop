import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/screens/collections_page.dart';
import 'package:union_shop/widgets/collection_tile.dart';

void main() {
  group('Collections Page Tests', () {
    testWidgets('navigates to /collections and displays grid', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // The Collections button should be present in the navbar
      final collectionsFinder = find.text('Collections');
      expect(collectionsFinder, findsOneWidget);

      // Tap the Collections button to navigate
      await tester.tap(collectionsFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify that we navigated to the collections page by checking for collection titles
      expect(find.text('Summer Sale'), findsOneWidget);
      expect(find.text('New Arrivals'), findsOneWidget);
    });

    testWidgets('displays all 8 collection tiles', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to collections
      await tester.tap(find.text('Collections'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify all 8 collection titles are visible
      expect(find.text('Summer Sale'), findsOneWidget);
      expect(find.text('New Arrivals'), findsOneWidget);
      expect(find.text('Clearance'), findsOneWidget);
      expect(find.text('Must Haves'), findsOneWidget);
      expect(find.text('Premium Collection'), findsOneWidget);
      expect(find.text('Essentials'), findsOneWidget);
      expect(find.text('Limited Edition'), findsOneWidget);
      expect(find.text('Gift Ideas'), findsOneWidget);
    });

    testWidgets('getColumnCount returns correct values', (tester) async {
      // Test mobile (< 600px)
      expect(CollectionsPage.getColumnCount(400), 2);

      // Test tablet (600-900px)
      expect(CollectionsPage.getColumnCount(750), 3);

      // Test desktop (> 900px)
      expect(CollectionsPage.getColumnCount(1280), 4);

      // Test edge cases
      expect(CollectionsPage.getColumnCount(599), 2);
      expect(CollectionsPage.getColumnCount(600), 3);
      expect(CollectionsPage.getColumnCount(899), 3);
      expect(CollectionsPage.getColumnCount(900), 4);
    });

    testWidgets(
        'tapping a collection tile navigates to collection details page',
        (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to collections
      await tester.tap(find.text('Collections'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Tap the first collection tile (Summer Sale)
      final summertileFinder = find.text('Summer Sale');
      expect(summertileFinder, findsOneWidget);
      await tester.tap(summertileFinder);
      await tester.pumpAndSettle();

      // After tapping, we should navigate to the collection details page
      // We should see the collection page content
      expect(find.text('Summer Sale'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('collection tiles are rendered as CollectionTile widgets',
        (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to collections
      await tester.tap(find.text('Collections'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Find all CollectionTile widgets
      final tilesFinder = find.byType(CollectionTile);
      expect(tilesFinder, findsWidgets);

      // Should find 8 tiles
      expect(tilesFinder, findsNWidgets(8));
    });

    testWidgets('collection tiles have Card and InkWell for tap feedback',
        (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to collections
      await tester.tap(find.text('Collections'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify Cards are present (one for each tile)
      expect(find.byType(Card), findsWidgets);

      // Verify InkWells are present for tap feedback
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('collections display in a GridView', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to collections
      await tester.tap(find.text('Collections'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify GridView.builder is used to render collections
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('back navigation returns from collections', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Navigate to collections
      await tester.tap(find.text('Collections'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify we're on collections page
      expect(find.text('Summer Sale'), findsOneWidget);

      // Use Navigator to go back instead of pageBack
      final navigatorState = tester.state<NavigatorState>(
        find.byType(Navigator),
      );
      navigatorState.pop();
      await tester.pumpAndSettle();

      // We should return to home - the Collections button should still be visible
      final collectionsButton = find.text('Collections');
      expect(collectionsButton, findsOneWidget);
    });
  });
}
