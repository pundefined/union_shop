import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/collection_tile.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('CollectionTile Widget Tests', () {
    final testCollection = Collection(
      id: 'test-collection',
      title: 'Test Collection',
      description: 'A test collection description',
      imageUrl: 'assets/images/backpack.png',
      items: [
        Product(
          id: 'test-1',
          name: 'Test Product',
          price: 24.99,
          imageUrl: 'assets/images/backpack.png',
          description: 'Test description',
          category: ProductCategory.product,
        ),
      ],
    );

    testWidgets('displays collection title', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 200,
            width: 200,
            child: CollectionTile(collection: testCollection),
          ),
        ),
      );

      expect(find.text('Test Collection'), findsOneWidget);
    });

    testWidgets('renders background image', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 200,
            width: 200,
            child: CollectionTile(collection: testCollection),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders inside a Card widget', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 200,
            width: 200,
            child: CollectionTile(collection: testCollection),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('has InkWell for tap feedback', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 200,
            width: 200,
            child: CollectionTile(collection: testCollection),
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('has gradient overlay for text contrast', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 200,
            width: 200,
            child: CollectionTile(collection: testCollection),
          ),
        ),
      );

      // Find the Container with gradient decoration
      final gradientContainer = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).gradient != null,
      );

      expect(gradientContainer, findsOneWidget);
    });

    testWidgets('truncates long titles', (tester) async {
      final longTitleCollection = Collection(
        id: 'long-title',
        title: 'This is a very long collection title that should be truncated',
        description: 'Description',
        imageUrl: 'assets/images/backpack.png',
        items: [],
      );

      await tester.pumpWidget(
        wrapWidget(
          SizedBox(
            height: 200,
            width: 200,
            child: CollectionTile(collection: longTitleCollection),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(
        find.text(longTitleCollection.title),
      );
      expect(textWidget.maxLines, 2);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
