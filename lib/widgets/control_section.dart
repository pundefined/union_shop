import 'package:flutter/material.dart';

/// A control section widget that displays filter and sort dropdown UI.
///
/// This widget provides a side-by-side layout for filter and sort dropdowns.
/// Allows users to select sort type and filter by category
class ControlSection extends StatelessWidget {
  final String currentSort;
  final String currentFilter;
  final Function(String) onSortChanged;
  final Function(String) onFilterChanged;

  const ControlSection({
    super.key,
    this.currentSort = 'name',
    this.currentFilter = 'all',
    required this.onSortChanged,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Filter By Dropdown
          Expanded(
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: currentFilter,
              decoration: InputDecoration(
                labelText: 'Filter By',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'all',
                  child: Text('All Products'),
                ),
                DropdownMenuItem(
                  value: 'product',
                  child: Text('Clothing'),
                ),
                DropdownMenuItem(
                  value: 'merchandise',
                  child: Text('Merchandise'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  onFilterChanged(value);
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          // Sort By Dropdown
          Expanded(
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: currentSort,
              decoration: InputDecoration(
                labelText: 'Sort By',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'name',
                  child: Text('Name'),
                ),
                DropdownMenuItem(
                  value: 'price_low',
                  child: Text('Price: Low to High'),
                ),
                DropdownMenuItem(
                  value: 'price_high',
                  child: Text('Price: High to Low'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  onSortChanged(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
