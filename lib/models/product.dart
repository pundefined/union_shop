import '../utils/slug.dart';

/// Enum for product categories.
enum ProductCategory {
  product,
  merchandise,
}

/// Model class representing a product within a collection.
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final ProductCategory category;
  final double? discountedPrice;
  final List<String>? colors;
  final List<String>? sizes;

  /// URL-safe slug for deep linking, auto-generated from name.
  final String slug;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    this.discountedPrice,
    this.colors,
    this.sizes,
    String? slug,
  }) : slug = slug ?? generateSlug(name);

  /// Finds a product by its slug from a list of products.
  ///
  /// Returns `null` if no product with the given slug is found.
  static Product? findBySlug(List<Product> products, String slug) {
    try {
      return products.firstWhere((p) => p.slug == slug);
    } catch (e) {
      return null;
    }
  }
}

/// Sample products for the collection page.
final List<Product> sampleProducts = [
  Product(
    id: 'product-1',
    name: 'Portsmouth Magnet',
    price: 2.50,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description:
        'A vibrant magnet featuring Portsmouth landmarks and the UPSU logo.',
    category: ProductCategory.merchandise,
  ),
  Product(
    id: 'product-2',
    name: 'Portsmouth Postcard',
    price: 1.50,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
    description: 'Beautiful postcard showcasing Portsmouth city views.',
    category: ProductCategory.merchandise,
  ),
  Product(
    id: 'product-3',
    name: 'University Hoodie',
    price: 25.00,
    discountedPrice: 19.99,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Cozy hoodie with UPSU branding',
    category: ProductCategory.product,
    colors: ['Navy', 'Grey', 'Black'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'product-4',
    name: 'UPSU Mug',
    price: 8.99,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
    description: 'Ceramic mug with UPSU logo.',
    category: ProductCategory.merchandise,
    colors: ['White', 'Black'],
  ),
  Product(
    id: 'product-5',
    name: 'Vinyl Sticker Pack',
    price: 3.99,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Set of 5 vinyl stickers featuring Portsmouth landmarks.',
    category: ProductCategory.merchandise,
  ),
  Product(
    id: 'product-6',
    name: 'Tote Bag',
    price: 12.50,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
    description: 'Spacious tote bag perfect for campus life.',
    category: ProductCategory.product,
    colors: ['Navy', 'Natural'],
  ),
];

/// Sample products for the home page summer range section.
final List<Product> summerRangeProducts = [
  Product(
    id: 'home-product-1',
    name: 'Placeholder Product 1',
    price: 10.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Placeholder Product 1',
    category: ProductCategory.product,
  ),
  Product(
    id: 'home-product-2',
    name: 'Placeholder Product 2',
    price: 15.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Placeholder Product 2',
    category: ProductCategory.product,
  ),
];

/// Sample products for the home page new arrivals section.
final List<Product> newArrivalsProducts = [
  Product(
    id: 'home-product-3',
    name: 'Placeholder Product 3',
    price: 20.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Placeholder Product 3',
    category: ProductCategory.product,
  ),
  Product(
    id: 'home-product-4',
    name: 'Placeholder Product 4',
    price: 25.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Placeholder Product 4',
    category: ProductCategory.product,
  ),
];

/// Sample products for the home page featured collection section.
final List<Product> featuredCollectionProducts = [
  Product(
    id: 'collection-product-1',
    name: 'Collection Product 1',
    price: 12.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Collection Product 1',
    category: ProductCategory.product,
  ),
  Product(
    id: 'collection-product-2',
    name: 'Collection Product 2',
    price: 18.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Collection Product 2',
    category: ProductCategory.product,
  ),
  Product(
    id: 'collection-product-3',
    name: 'Collection Product 3',
    price: 22.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Collection Product 3',
    category: ProductCategory.product,
  ),
  Product(
    id: 'collection-product-4',
    name: 'Collection Product 4',
    price: 28.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Collection Product 4',
    category: ProductCategory.product,
  ),
];
