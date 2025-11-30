import 'product.dart';
import '../utils/slug.dart';

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

// =============================================================================
// SAMPLE COLLECTIONS
// =============================================================================

/// Essentials collection - everyday items students need.
final Collection essentialsCollection = Collection(
  id: 'essentials',
  title: 'Essentials',
  description:
      'Everything you need for student life. From bags to basics, we\'ve got you covered with quality everyday items.',
  imageUrl:
      'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500&h=500&fit=crop',
  items: essentialsProducts,
);

/// Summer Sale collection - seasonal discounts.
final Collection summerSaleCollection = Collection(
  id: 'summer-sale',
  title: 'Summer Sale',
  description:
      'Beat the heat with our summer essentials! Grab these hot deals before they\'re gone.',
  imageUrl:
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&h=500&fit=crop',
  items: summerSaleProducts,
);

/// New Arrivals collection - latest products.
final Collection newArrivalsCollection = Collection(
  id: 'new-arrivals',
  title: 'New Arrivals',
  description:
      'Fresh finds just landed! Check out our latest additions to the store.',
  imageUrl:
      'https://images.unsplash.com/photo-1505695511574-73f5e69a7b2e?w=500&h=500&fit=crop',
  items: newArrivalsProducts,
);

/// Signature Range collection - premium products.
final Collection signatureRangeCollection = Collection(
  id: 'signature-range',
  title: 'Signature Range',
  description:
      'Our premium collection featuring high-quality items with elegant university branding. Perfect for alumni and special occasions.',
  imageUrl:
      'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500&h=500&fit=crop',
  items: signatureRangeProducts,
);

/// Winter Favourites collection - cold weather essentials.
final Collection winterFavouritesCollection = Collection(
  id: 'winter-favourites',
  title: 'Winter Favourites',
  description:
      'Stay warm and cozy with our winter essentials. From puffer jackets to thermal socks, we\'ve got you covered.',
  imageUrl:
      'https://images.unsplash.com/photo-1544923246-77307dd628b5?w=500&h=500&fit=crop',
  items: winterFavouritesProducts,
);

/// All collections available in the store.
final List<Collection> sampleCollections = [
  essentialsCollection,
  summerSaleCollection,
  newArrivalsCollection,
  signatureRangeCollection,
  winterFavouritesCollection,
];

/// Default collection for backwards compatibility.
final Collection sampleCollection = essentialsCollection;
