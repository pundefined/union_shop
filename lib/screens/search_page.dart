import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                onSubmitted: _performSearch,
              ),
              const SizedBox(height: 24),

              // Results
              if (_searchResults.isNotEmpty) ...[
                Text(
                  '${_searchResults.length} ${_searchResults.length == 1 ? 'result' : 'results'} found',
                  style: TextStyles.bodyText.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                _buildResultsGrid(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsGrid() {
    // Calculate columns based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600
        ? 1
        : screenWidth < 900
            ? 2
            : 3;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: _searchResults.map((product) {
        final cardWidth = crossAxisCount == 1
            ? double.infinity
            : (MediaQuery.of(context).size.width -
                    48 -
                    (16 * (crossAxisCount - 1))) /
                crossAxisCount;
        return SizedBox(
          width:
              crossAxisCount == 1 ? double.infinity : cardWidth.clamp(0, 350),
          height: crossAxisCount == 1 ? 120 : 280,
          child: _buildResultCard(product),
        );
      }).toList(),
    );
  }

  Widget _buildResultCard(Product product) {
    final excerpt = product.description.length > 80
        ? '${product.description.substring(0, 80)}...'
        : product.description;

    return InkWell(
      onTap: () => context.go('/products/${product.slug}'),
      borderRadius: BorderRadius.circular(8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported,
                        size: 40, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: TextStyles.productCardTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(excerpt,
                          style: TextStyles.bodyText
                              .copyWith(fontSize: 12, color: Colors.grey[600]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text('£${product.price.toStringAsFixed(2)}',
                        style: TextStyles.productPrice),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
