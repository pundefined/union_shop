import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/styles/text_styles.dart';
import 'package:union_shop/utils/responsive.dart';
import 'package:union_shop/widgets/product_card.dart';

/// Search page that allows users to search for products by name or description.
class SearchPage extends StatefulWidget {
  /// Initial search query from URL parameter.
  final String? initialQuery;

  const SearchPage({super.key, this.initialQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  List<Product> _searchResults = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
    // If there's an initial query, perform the search
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      // Use addPostFrameCallback to ensure widget is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _performSearch(widget.initialQuery!);
      });
    }
  }

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
        _hasSearched = false;
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
      _hasSearched = true;
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
                onSubmitted: _performSearch,
              ),
              const SizedBox(height: 24),

              // Results or empty state
              if (_searchResults.isNotEmpty) ...[
                Text(
                  '${_searchResults.length} ${_searchResults.length == 1 ? 'result' : 'results'} found',
                  style: TextStyles.bodyText.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                _buildResultsGrid(),
              ] else if (_hasSearched) ...[
                _buildEmptyState(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 48),
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyles.productHeading.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search term',
            style: TextStyles.bodyText.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsGrid() {
    // Calculate columns based on screen width
    final screenWidth = context.screenWidth;
    final crossAxisCount = context.gridColumnCount;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: _searchResults.map((product) {
        final cardWidth =
            (screenWidth - 48 - (16 * (crossAxisCount - 1))) / crossAxisCount;
        return SizedBox(
          width: cardWidth.clamp(120, 280).toDouble(),
          height: 220,
          child: ProductCard(product: product),
        );
      }).toList(),
    );
  }
}
