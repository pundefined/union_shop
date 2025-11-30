import 'product.dart';

/// Generates a URL-safe slug from a string.
///
/// Converts to lowercase, replaces spaces and special characters with hyphens,
/// removes consecutive hyphens, and trims hyphens from start/end.
String generateSlug(String input) {
  return input
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\s-]'), '') // Remove special characters
      .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
      .replaceAll(RegExp(r'-+'), '-') // Remove consecutive hyphens
      .replaceAll(RegExp(r'^-|-$'), ''); // Trim hyphens from start/end
}

/// Model class representing a product collection.
class Collection {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<Product> items;

  /// URL-safe slug for deep linking, auto-generated from title.
  final String slug;

  Collection({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.items,
    String? slug,
  }) : slug = slug ?? generateSlug(title);

  /// Finds a collection by its slug from a list of collections.
  ///
  /// Returns `null` if no collection with the given slug is found.
  static Collection? findBySlug(List<Collection> collections, String slug) {
    try {
      return collections.firstWhere((c) => c.slug == slug);
    } catch (e) {
      return null;
    }
  }
}

/// Sample data for demonstration and testing.
final Collection sampleCollection = Collection(
  id: 'collection-1',
  title: 'New Arrivals',
  description:
      'Discover the latest additions to our store. Fresh products handpicked for you.',
  imageUrl:
      'https://images.unsplash.com/photo-1505695511574-73f5e69a7b2e?w=500&h=500&fit=crop',
  items: sampleProducts,
);

/// Sample collections data with 8 curated product groups for the collections grid.
final List<Collection> sampleCollections = [
  Collection(
    id: 'summer',
    title: 'Summer Sale',
    description: 'Beat the heat with our summer collection',
    imageUrl:
        'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=500&h=500&fit=crop',
    items: [],
  ),
  Collection(
    id: 'arrivals',
    title: 'New Arrivals',
    description: 'Discover what\'s new this season',
    imageUrl:
        'https://images.unsplash.com/photo-1505695511574-73f5e69a7b2e?w=500&h=500&fit=crop',
    items: [],
  ),
  Collection(
    id: 'sale',
    title: 'Sale',
    description: 'Great deals on selected items',
    imageUrl:
        'https://images.unsplash.com/photo-1552062407-291ce3f93c4f?w=500&h=500&fit=crop',
    items: [],
  ),
  Collection(
    id: 'musthaves',
    title: 'Must Haves',
    description: 'Customer favorites and bestsellers',
    imageUrl:
        'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=500&h=500&fit=crop',
    items: [],
  ),
  Collection(
    id: 'premium',
    title: 'Premium Collection',
    description: 'Luxury items for the discerning shopper',
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&h=500&fit=crop',
    items: [],
  ),
  Collection(
    id: 'essentials',
    title: 'Essentials',
    description: 'The basics you always need',
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop',
    items: [],
  ),
  Collection(
    id: 'limited',
    title: 'Limited Edition',
    description: 'Exclusive items available for a limited time',
    imageUrl:
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500&h=500&fit=crop',
    items: [],
  ),
  Collection(
    id: 'gifts',
    title: 'Gift Ideas',
    description: 'Perfect presents for every occasion',
    imageUrl:
        'https://images.unsplash.com/photo-1513225357062-080301f385cf?w=500&h=500&fit=crop',
    items: [],
  ),
];
