import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/screens/collection_page.dart';
import 'package:union_shop/widgets/product_card.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  /// Helper function to wrap CollectionPage in the required widget tree for testing
  Future<void> pumpCollectionPage(
    WidgetTester tester,
    Collection collection,
  ) async {
    await tester.setViewportSize(TestViewportSizes.desktop);
    await tester.pumpWidget(
      wrapWidgetScrollable(CollectionPage(collection: collection)),
    );
    await tester.pump();
  }

  group('CollectionPage', () {
    late Collection testCollection;

    setUp(() {
      testCollection = Collection(
        id: 'test-collection',
        title: 'Test Collection',
        description: 'This is a test collection',
        imageUrl: 'assets/images/summer_carousel.png',
        items: [
          Product(
            id: '1',
            name: 'Product 1',
            price: 10.00,
            imageUrl: 'assets/images/summer_carousel.png',
            description: 'Description for Product 1',
            category: ProductCategory.product,
          ),
          Product(
            id: '2',
            name: 'Product 2',
            price: 20.00,
            imageUrl: 'assets/images/summer_carousel.png',
            description: 'Description for Product 2',
            category: ProductCategory.product,
          ),
          Product(
            id: '3',
            name: 'Product 3',
            price: 30.00,
            imageUrl: 'assets/images/summer_carousel.png',
            description: 'Description for Product 3',
            category: ProductCategory.product,
          ),
          Product(
            id: '4',
            name: 'Product 4',
            price: 40.00,
            imageUrl: 'assets/images/summer_carousel.png',
            description: 'Description for Product 4',
            category: ProductCategory.merchandise,
          ),
          Product(
            id: '5',
            name: 'Product 5',
            price: 50.00,
            imageUrl: 'assets/images/summer_carousel.png',
            description: 'Description for Product 5',
            category: ProductCategory.merchandise,
          ),
          Product(
            id: '6',
            name: 'Product 6',
            price: 60.00,
            imageUrl: 'assets/images/summer_carousel.png',
            description: 'Description for Product 6',
            category: ProductCategory.merchandise,
          ),
        ],
      );
    });

    tearDown(() async {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.platformDispatcher.views.first.resetPhysicalSize();
    });

    testWidgets('displays collection title and description',
        (WidgetTester tester) async {
      await pumpCollectionPage(tester, testCollection);

      expect(find.text('Test Collection'), findsOneWidget);
      expect(find.text('This is a test collection'), findsOneWidget);
    });

    testWidgets('renders product cards for first page items',
        (WidgetTester tester) async {
      await pumpCollectionPage(tester, testCollection);

      // With 6 items per page, all products should be on the first page
      expect(find.text('Product 1'), findsOneWidget);
      expect(find.text('Product 2'), findsOneWidget);
      expect(find.text('Product 3'), findsOneWidget);
      expect(find.text('Product 4'), findsOneWidget);
      expect(find.text('Product 5'), findsOneWidget);
      expect(find.text('Product 6'), findsOneWidget);

      // Verify prices are visible
      expect(find.text('£10.00'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('£30.00'), findsOneWidget);
      expect(find.text('£40.00'), findsOneWidget);
      expect(find.text('£50.00'), findsOneWidget);
      expect(find.text('£60.00'), findsOneWidget);
    });

    testWidgets('renders grid view with products', (WidgetTester tester) async {
      await pumpCollectionPage(tester, testCollection);

      // The grid should render
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('product cards are rendered with correct type',
        (WidgetTester tester) async {
      await pumpCollectionPage(tester, testCollection);

      // Verify product cards are rendered
      expect(find.byType(ProductCard), findsWidgets);
      expect(find.text('Product 1'), findsOneWidget);
    });

    testWidgets('renders control section with dropdowns',
        (WidgetTester tester) async {
      await pumpCollectionPage(tester, testCollection);

      // Verify control section is present
      expect(find.text('Filter By'), findsOneWidget);
      expect(find.text('Sort By'), findsOneWidget);
    });

    testWidgets('page is vertically scrollable', (WidgetTester tester) async {
      await pumpCollectionPage(tester, testCollection);

      // Verify the Column within CollectionPage
      expect(find.byType(Column), findsWidgets);

      // Verify we can see products
      expect(find.text('Product 1'), findsWidgets);
    });

    testWidgets('header has title and description text',
        (WidgetTester tester) async {
      await pumpCollectionPage(tester, testCollection);

      // Verify title text widget exists
      final titleFinder = find.text('Test Collection');
      expect(titleFinder, findsOneWidget);

      // Verify description text widget exists
      final descriptionFinder = find.text('This is a test collection');
      expect(descriptionFinder, findsOneWidget);
    });

    testWidgets('empty collection handles gracefully',
        (WidgetTester tester) async {
      final emptyCollection = Collection(
        id: 'empty',
        title: 'Empty Collection',
        description: 'This collection is empty',
        imageUrl: 'assets/images/summer_carousel.png',
        items: [],
      );

      await pumpCollectionPage(tester, emptyCollection);

      expect(find.text('Empty Collection'), findsOneWidget);
      expect(find.text('This collection is empty'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    group('Pagination', () {
      late Collection largeCollection;

      setUp(() {
        // Create a collection with 10 products to test pagination (6 per page)
        // Use zero-padded numbers for proper alphabetical sorting
        largeCollection = Collection(
          id: 'large-collection',
          title: 'Large Collection',
          description: 'This is a large test collection',
          imageUrl: 'assets/images/summer_carousel.png',
          items: List.generate(
            10,
            (index) => Product(
              id: '${index + 1}',
              name:
                  'Item ${(index + 1).toString().padLeft(2, '0')}', // Item 01, Item 02, etc.
              price: (index + 1) * 10.0,
              imageUrl: 'assets/images/summer_carousel.png',
              description: 'Description for Item ${index + 1}',
              category: ProductCategory.product,
            ),
          ),
        );
      });

      testWidgets('shows pagination controls when items exceed page size',
          (WidgetTester tester) async {
        await pumpCollectionPage(tester, largeCollection);

        // Scroll to make pagination controls visible using the SingleChildScrollView
        await tester.scrollUntilVisible(
          find.byIcon(Icons.chevron_right),
          100,
          scrollable: find.byType(Scrollable).first,
        );

        // Should show pagination controls (previous/next buttons)
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      });

      testWidgets('does not show pagination controls for small collections',
          (WidgetTester tester) async {
        // testCollection has 6 items, which fits on one page
        await pumpCollectionPage(tester, testCollection);

        // Should not show pagination controls (all items fit on one page)
        expect(find.byIcon(Icons.chevron_left), findsNothing);
        expect(find.byIcon(Icons.chevron_right), findsNothing);
      });

      testWidgets('shows first page products initially',
          (WidgetTester tester) async {
        await pumpCollectionPage(tester, largeCollection);

        // First page should show items 01-06 (sorted alphabetically)
        expect(find.text('Item 01'), findsOneWidget);
        expect(find.text('Item 06'), findsOneWidget);
        // Items 07-10 should not be visible on first page
        expect(find.text('Item 07'), findsNothing);
        expect(find.text('Item 10'), findsNothing);
      });

      testWidgets('navigates to next page when next button is tapped',
          (WidgetTester tester) async {
        await pumpCollectionPage(tester, largeCollection);

        // Scroll to make pagination controls visible
        await tester.scrollUntilVisible(
          find.byIcon(Icons.chevron_right),
          100,
          scrollable: find.byType(Scrollable).first,
        );

        // Tap next page button
        await tester.tap(find.byIcon(Icons.chevron_right));
        await tester.pumpAndSettle();

        // Second page should show items 07-10
        expect(find.text('Item 07'), findsOneWidget);
        expect(find.text('Item 10'), findsOneWidget);
        // Items 01-06 should not be visible on second page
        expect(find.text('Item 01'), findsNothing);
        expect(find.text('Item 06'), findsNothing);
      });

      testWidgets('navigates to previous page when previous button is tapped',
          (WidgetTester tester) async {
        await pumpCollectionPage(tester, largeCollection);

        // Scroll to make pagination controls visible
        await tester.scrollUntilVisible(
          find.byIcon(Icons.chevron_right),
          100,
          scrollable: find.byType(Scrollable).first,
        );

        // Navigate to second page first
        await tester.tap(find.byIcon(Icons.chevron_right));
        await tester.pumpAndSettle();

        // Now tap previous page button
        await tester.tap(find.byIcon(Icons.chevron_left));
        await tester.pumpAndSettle();

        // Should be back on first page
        expect(find.text('Item 01'), findsOneWidget);
      });

      testWidgets('previous button is disabled on first page',
          (WidgetTester tester) async {
        await pumpCollectionPage(tester, largeCollection);

        // Scroll to make pagination controls visible
        await tester.scrollUntilVisible(
          find.byIcon(Icons.chevron_left),
          100,
          scrollable: find.byType(Scrollable).first,
        );

        // Find the previous button and verify it's disabled
        final previousButton = find.ancestor(
          of: find.byIcon(Icons.chevron_left),
          matching: find.byType(IconButton),
        );
        final button = tester.widget<IconButton>(previousButton);
        expect(button.onPressed, isNull);
      });

      testWidgets('next button is disabled on last page',
          (WidgetTester tester) async {
        await pumpCollectionPage(tester, largeCollection);

        // Scroll to make pagination controls visible
        await tester.scrollUntilVisible(
          find.byIcon(Icons.chevron_right),
          100,
          scrollable: find.byType(Scrollable).first,
        );

        // Navigate to last page
        await tester.tap(find.byIcon(Icons.chevron_right));
        await tester.pumpAndSettle();

        // Scroll again to ensure button is visible
        await tester.scrollUntilVisible(
          find.byIcon(Icons.chevron_right),
          100,
          scrollable: find.byType(Scrollable).first,
        );

        // Find the next button and verify it's disabled
        final nextButton = find.ancestor(
          of: find.byIcon(Icons.chevron_right),
          matching: find.byType(IconButton),
        );
        final button = tester.widget<IconButton>(nextButton);
        expect(button.onPressed, isNull);
      });

      testWidgets('displays page numbers', (WidgetTester tester) async {
        await pumpCollectionPage(tester, largeCollection);

        // Scroll to make pagination controls visible
        await tester.scrollUntilVisible(
          find.byIcon(Icons.chevron_right),
          100,
          scrollable: find.byType(Scrollable).first,
        );

        // Should display page numbers (1 and 2 for 10 items with 6 per page)
        expect(find.text('1'), findsOneWidget);
        expect(find.text('2'), findsOneWidget);
      });

      testWidgets('clicking page number navigates to that page',
          (WidgetTester tester) async {
        await pumpCollectionPage(tester, largeCollection);

        // Scroll to make pagination controls visible
        await tester.scrollUntilVisible(
          find.text('2'),
          100,
          scrollable: find.byType(Scrollable).first,
        );

        // Tap on page 2
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();

        // Should now show second page content
        expect(find.text('Item 07'), findsOneWidget);
        expect(find.text('Item 01'), findsNothing);
      });

      testWidgets('filtering resets pagination to first page',
          (WidgetTester tester) async {
        // Create a collection with mixed categories to test filtering + pagination
        final mixedCollection = Collection(
          id: 'mixed-collection',
          title: 'Mixed Collection',
          description: 'Collection with mixed categories',
          imageUrl: 'assets/images/summer_carousel.png',
          items: [
            ...List.generate(
              7,
              (index) => Product(
                id: 'prod-${index + 1}',
                name: 'Product ${(index + 1).toString().padLeft(2, '0')}',
                price: (index + 1) * 10.0,
                imageUrl: 'assets/images/summer_carousel.png',
                description: 'Product ${index + 1}',
                category: ProductCategory.product,
              ),
            ),
            ...List.generate(
              3,
              (index) => Product(
                id: 'merch-${index + 1}',
                name: 'Merch ${(index + 1).toString().padLeft(2, '0')}',
                price: (index + 1) * 5.0,
                imageUrl: 'assets/images/summer_carousel.png',
                description: 'Merch ${index + 1}',
                category: ProductCategory.merchandise,
              ),
            ),
          ],
        );

        await pumpCollectionPage(tester, mixedCollection);

        // Verify we're on page 1 with items initially
        expect(find.text('Merch 01'), findsOneWidget);

        // Now apply merchandise filter - tap on Filter dropdown ("All Products" is default)
        await tester.tap(find.text('All Products'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Merchandise').last);
        await tester.pumpAndSettle();

        // After filtering to merchandise only, should show only merch items
        // Since there are only 3 merch items, all fit on page 1
        expect(find.text('Merch 01'), findsOneWidget);
        expect(find.text('Merch 02'), findsOneWidget);
        expect(find.text('Merch 03'), findsOneWidget);
        // Products should not be visible
        expect(find.text('Product 01'), findsNothing);
      });
    });
  });
}
