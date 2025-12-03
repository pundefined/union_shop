import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/control_section.dart';

import '../helpers/widget_test_helper.dart';

void main() {
  group('ControlSection Widget Tests', () {
    testWidgets('displays Filter By dropdown', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          ControlSection(
            onSortChanged: (_) {},
            onFilterChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Filter By'), findsOneWidget);
    });

    testWidgets('displays Sort By dropdown', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          ControlSection(
            onSortChanged: (_) {},
            onFilterChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Sort By'), findsOneWidget);
    });

    testWidgets('has two DropdownButtonFormField widgets', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          ControlSection(
            onSortChanged: (_) {},
            onFilterChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(2));
    });

    testWidgets('shows filter options when dropdown is tapped', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          ControlSection(
            onSortChanged: (_) {},
            onFilterChanged: (_) {},
          ),
        ),
      );

      // Tap the Filter By dropdown
      await tester.tap(find.text('All Products'));
      await tester.pumpAndSettle();

      // Should show filter options
      expect(find.text('Clothing'), findsOneWidget);
      expect(find.text('Merchandise'), findsOneWidget);
    });

    testWidgets('shows sort options when dropdown is tapped', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          ControlSection(
            onSortChanged: (_) {},
            onFilterChanged: (_) {},
          ),
        ),
      );

      // Tap the Sort By dropdown (find by 'Name' which is the default)
      await tester.tap(find.text('Name'));
      await tester.pumpAndSettle();

      // Should show sort options
      expect(find.text('Price: Low to High'), findsOneWidget);
      expect(find.text('Price: High to Low'), findsOneWidget);
    });

    testWidgets('calls onFilterChanged when filter selection changes',
        (tester) async {
      String? selectedFilter;

      await tester.pumpWidget(
        wrapWidget(
          ControlSection(
            onSortChanged: (_) {},
            onFilterChanged: (value) => selectedFilter = value,
          ),
        ),
      );

      // Tap the Filter By dropdown
      await tester.tap(find.text('All Products'));
      await tester.pumpAndSettle();

      // Select 'Clothing'
      await tester.tap(find.text('Clothing').last);
      await tester.pumpAndSettle();

      expect(selectedFilter, 'product');
    });

    testWidgets('calls onSortChanged when sort selection changes',
        (tester) async {
      String? selectedSort;

      await tester.pumpWidget(
        wrapWidget(
          ControlSection(
            onSortChanged: (value) => selectedSort = value,
            onFilterChanged: (_) {},
          ),
        ),
      );

      // Tap the Sort By dropdown
      await tester.tap(find.text('Name'));
      await tester.pumpAndSettle();

      // Select 'Price: Low to High'
      await tester.tap(find.text('Price: Low to High').last);
      await tester.pumpAndSettle();

      expect(selectedSort, 'price_low');
    });

    testWidgets('uses provided currentFilter value', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          ControlSection(
            currentFilter: 'product',
            onSortChanged: (_) {},
            onFilterChanged: (_) {},
          ),
        ),
      );

      // Clothing should be shown as the current value
      expect(find.text('Clothing'), findsOneWidget);
    });

    testWidgets('uses provided currentSort value', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          ControlSection(
            currentSort: 'price_low',
            onSortChanged: (_) {},
            onFilterChanged: (_) {},
          ),
        ),
      );

      // Price: Low to High should be shown as the current value
      expect(find.text('Price: Low to High'), findsOneWidget);
    });
  });
}
