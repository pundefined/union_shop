import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/styles/text_styles.dart';

/// Search page that allows users to search for products by name or description.
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Gets all products from all collections (deduplicated).
  List<Product> _getAllProducts() {
    final Set<String> seenIds = {};
    final List<Product> allProducts = [];

    for (final collection in sampleCollections) {
      for (final product in collection.items) {
        if (!seenIds.contains(product.id)) {
          seenIds.add(product.id);
          allProducts.add(product);
        }
      }
    }

    return allProducts;
  }

  /// Performs search and updates results.
  void _performSearch(String query) {
    final searchTerm = query.trim().toLowerCase();

    if (searchTerm.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final allProducts = _getAllProducts();
    final results = allProducts.where((product) {
      final nameMatch = product.name.toLowerCase().contains(searchTerm);
      final descriptionMatch =
          product.description.toLowerCase().contains(searchTerm);
      return nameMatch || descriptionMatch;
    }).toList();

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text('Search Products', style: TextStyles.productHeading),
              const SizedBox(height: 24),

              // Search input
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by product name or description...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                textInputAction: TextInputAction.search,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
