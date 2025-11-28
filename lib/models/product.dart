/// Model class representing a product within a collection.
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final double? discountedPrice;
  final List<String>? colors;
  final List<String>? sizes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.discountedPrice,
    this.colors,
    this.sizes,
  });
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
    colors: ['White', 'Black'],
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
  ),
  Product(
    id: 'home-product-2',
    name: 'Placeholder Product 2',
    price: 15.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Placeholder Product 2',
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
  ),
  Product(
    id: 'home-product-4',
    name: 'Placeholder Product 4',
    price: 25.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Placeholder Product 4',
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
  ),
  Product(
    id: 'collection-product-2',
    name: 'Collection Product 2',
    price: 18.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Collection Product 2',
  ),
  Product(
    id: 'collection-product-3',
    name: 'Collection Product 3',
    price: 22.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Collection Product 3',
  ),
  Product(
    id: 'collection-product-4',
    name: 'Collection Product 4',
    price: 28.00,
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    description: 'Collection Product 4',
  ),
];
