import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/screens/collection_page.dart';
import 'package:union_shop/widgets/product_card.dart';

void main() {
  group('CollectionPage', () {
    late Collection testCollection;

    setUp(() {
      testCollection = Collection(
        id: 'test-collection',
        title: 'Test Collection',
        description: 'This is a test collection',
        imageUrl: 'https://via.placeholder.com/300x300?text=Test+Collection',
        items: [
          Product(
            id: '1',
            name: 'Product 1',
            price: 10.00,
            imageUrl: 'https://via.placeholder.com/300x300?text=Product+1',
            description: 'Description for Product 1',
            category: ProductCategory.product,
          ),
          Product(
            id: '2',
            name: 'Product 2',
            price: 20.00,
            imageUrl: 'https://via.placeholder.com/300x300?text=Product+2',
            description: 'Description for Product 2',
            category: ProductCategory.product,
          ),
          Product(
            id: '3',
            name: 'Product 3',
            price: 30.00,
            imageUrl: 'https://via.placeholder.com/300x300?text=Product+3',
            description: 'Description for Product 3',
            category: ProductCategory.product,
          ),
          Product(
            id: '4',
            name: 'Product 4',
            price: 40.00,
            imageUrl: 'https://via.placeholder.com/300x300?text=Product+4',
            description: 'Description for Product 4',
            category: ProductCategory.merchandise,
          ),
          Product(
            id: '5',
            name: 'Product 5',
            price: 50.00,
            imageUrl: 'https://via.placeholder.com/300x300?text=Product+5',
            description: 'Description for Product 5',
            category: ProductCategory.merchandise,
          ),
          Product(
            id: '6',
            name: 'Product 6',
            price: 60.00,
            imageUrl: 'https://via.placeholder.com/300x300?text=Product+6',
            description: 'Description for Product 6',
            category: ProductCategory.merchandise,
          ),
        ],
      );
    });

    testWidgets('displays collection title and description',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CollectionPage(collection: testCollection),
          ),
        ),
      );

      expect(find.text('Test Collection'), findsOneWidget);
      expect(find.text('This is a test collection'), findsOneWidget);
    });

    testWidgets('renders product cards for all items',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CollectionPage(collection: testCollection),
          ),
        ),
      );

      // Verify all product names are visible
      expect(find.text('Product 1'), findsOneWidget);
      expect(find.text('Product 2'), findsOneWidget);
      expect(find.text('Product 3'), findsOneWidget);
      expect(find.text('Product 4'), findsOneWidget);
      expect(find.text('Product 5'), findsOneWidget);
      expect(find.text('Product 6'), findsOneWidget);

      // Verify all prices are visible
      expect(find.text('£10.00'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('£30.00'), findsOneWidget);
      expect(find.text('£40.00'), findsOneWidget);
      expect(find.text('£50.00'), findsOneWidget);
      expect(find.text('£60.00'), findsOneWidget);
    });

    testWidgets('renders grid view with products', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CollectionPage(collection: testCollection),
          ),
        ),
      );

      // The grid should render
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('product card is tappable and shows feedback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == '/product') {
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(child: Text('Product Detail Page')),
                ),
              );
            }
            return null;
          },
          home: Scaffold(
            body: CollectionPage(collection: testCollection),
          ),
        ),
      );

      // Find and tap the first product card
      expect(find.text('Product 1'), findsOneWidget);

      // Tap on the product card (InkWell wraps the Card)
      await tester.tap(find.byType(ProductCard).first);
      await tester.pumpAndSettle();

      // Verify navigation occurs (product detail page is shown)
      expect(find.text('Product Detail Page'), findsOneWidget);
    });

    testWidgets('renders control section with dropdowns',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CollectionPage(collection: testCollection),
          ),
        ),
      );

      // Verify control section is present
      expect(find.text('Filter By'), findsOneWidget);
      expect(find.text('Sort By'), findsOneWidget);
    });

    testWidgets('page is vertically scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CollectionPage(collection: testCollection),
          ),
        ),
      );

      // Verify SingleChildScrollView is present
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Verify the column within the scrollview
      expect(find.byType(Column), findsWidgets);

      // Verify we can see products
      expect(find.text('Product 1'), findsWidgets);
    });

    testWidgets('header has title and description text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CollectionPage(collection: testCollection),
          ),
        ),
      );

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
        imageUrl: 'https://via.placeholder.com/300x300?text=Empty+Collection',
        items: [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CollectionPage(collection: emptyCollection),
          ),
        ),
      );

      expect(find.text('Empty Collection'), findsOneWidget);
      expect(find.text('This collection is empty'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
