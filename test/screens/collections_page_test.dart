import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/screens/collections_page.dart';
import 'package:union_shop/utils/responsive.dart';
import 'package:union_shop/widgets/collection_tile.dart';

void main() {
  group('Collections Page Tests', () {
    Widget createTestWidget() {
      return ChangeNotifierProvider<CartProvider>(
        create: (_) => CartProvider(),
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: CollectionsPage(),
            ),
          ),
        ),
      );
    }

    testWidgets('displays all 5 collection tiles', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify all 5 collection titles are visible
      expect(find.text('Summer Sale'), findsOneWidget);
      expect(find.text('New Arrivals'), findsOneWidget);
      expect(find.text('Essentials'), findsOneWidget);
      expect(find.text('Signature Range'), findsOneWidget);
      expect(find.text('Winter Favourites'), findsOneWidget);
    });

    testWidgets('getGridColumnCount returns correct values', (tester) async {
      // Test mobile (< 600px)
      expect(Responsive.getGridColumnCount(400), 2);
      expect(Responsive.getGridColumnCount(599), 2);

      // Test desktop (>= 600px)
      expect(Responsive.getGridColumnCount(600), 4);
      expect(Responsive.getGridColumnCount(1280), 4);
    });

    testWidgets('collection tiles are rendered as CollectionTile widgets',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find all CollectionTile widgets
      final tilesFinder = find.byType(CollectionTile);
      expect(tilesFinder, findsWidgets);

      // Should find 5 tiles (the actual number of collections)
      expect(tilesFinder, findsNWidgets(5));
    });

    testWidgets('collection tiles have Card and InkWell for tap feedback',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify Cards are present (one for each tile)
      expect(find.byType(Card), findsWidgets);

      // Verify InkWells are present for tap feedback
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('collections display in a GridView', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify GridView.builder is used to render collections
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
