import 'product.dart';

/// Model class representing a product collection.
class Collection {
  final String id;
  final String title;
  final String description;
  final List<Product> items;

  Collection({
    required this.id,
    required this.title,
    required this.description,
    required this.items,
  });
}

/// Sample data for demonstration and testing.
final Collection sampleCollection = Collection(
  id: 'collection-1',
  title: 'New Arrivals',
  description:
      'Discover the latest additions to our store. Fresh products handpicked for you.',
  items: [
    Product(
      id: 'product-1',
      name: 'Portsmouth Magnet',
      price: 2.50,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      description:
          'A vibrant magnet featuring Portsmouth landmarks and the UPSU logo.',
    ),
    Product(
      id: 'product-2',
      name: 'Portsmouth Postcard',
      price: 1.50,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      description: 'Beautiful postcard showcasing Portsmouth city views.',
    ),
    Product(
      id: 'product-3',
      name: 'University Hoodie',
      price: 25.00,
      discountedPrice: 19.99,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      description: 'Cozy hoodie with UPSU branding',
      colours: ['Navy', 'Grey', 'Black'],
      sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    ),
    Product(
      id: 'product-4',
      name: 'UPSU Mug',
      price: 8.99,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      description: 'Ceramic mug with UPSU logo.',
      colours: ['White', 'Black'],
    ),
    Product(
      id: 'product-5',
      name: 'Vinyl Sticker Pack',
      price: 3.99,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      description: 'Set of 5 vinyl stickers featuring Portsmouth landmarks.',
    ),
    Product(
      id: 'product-6',
      name: 'Tote Bag',
      price: 12.50,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      description: 'Spacious tote bag perfect for campus life.',
      colours: ['Navy', 'Natural'],
    ),
  ],
);
