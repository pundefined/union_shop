import 'product.dart';

/// Model class representing a product collection.
class Collection {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<Product> items;

  Collection({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.items,
  });
}

/// Sample data for demonstration and testing.
final Collection sampleCollection = Collection(
  id: 'collection-1',
  title: 'New Arrivals',
  description:
      'Discover the latest additions to our store. Fresh products handpicked for you.',
  imageUrl:
      'https://images.unsplash.com/photo-1505695511574-73f5e69a7b2e?w=500&h=500&fit=crop',
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
  ],
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
