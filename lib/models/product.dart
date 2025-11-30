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

// =============================================================================
// ESSENTIALS COLLECTION PRODUCTS
// =============================================================================

final List<Product> essentialsProducts = [
  Product(
    id: 'essentials-1',
    name: 'Canvas Tote Bag',
    price: 14.99,
    imageUrl:
        'https://images.unsplash.com/photo-1544816155-12df9643f363?w=500&h=500&fit=crop',
    description:
        'Durable canvas tote bag perfect for carrying books, groceries, or everyday essentials. Features reinforced handles and a spacious interior.',
    category: ProductCategory.product,
    colors: ['Natural', 'Navy', 'Black'],
  ),
  Product(
    id: 'essentials-2',
    name: 'Classic Hoodie',
    price: 34.99,
    imageUrl:
        'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500&h=500&fit=crop',
    description:
        'Soft and cozy hoodie made from premium cotton blend. Perfect for chilly days on campus or lounging at home.',
    category: ProductCategory.product,
    colors: ['Grey', 'Navy', 'Black', 'Burgundy'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'essentials-3',
    name: 'Basic T-Shirt',
    price: 18.99,
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500&h=500&fit=crop',
    description:
        'Classic fit t-shirt made from 100% organic cotton. A wardrobe staple that goes with everything.',
    category: ProductCategory.product,
    colors: ['White', 'Black', 'Grey', 'Navy'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'essentials-4',
    name: 'Lanyard with Card Holder',
    price: 6.99,
    imageUrl:
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=500&h=500&fit=crop',
    description:
        'Convenient lanyard with detachable card holder. Keep your ID and cards easily accessible.',
    category: ProductCategory.merchandise,
    colors: ['Purple', 'Blue', 'Black'],
  ),
  Product(
    id: 'essentials-5',
    name: 'Notebook Set',
    price: 12.99,
    imageUrl:
        'https://images.unsplash.com/photo-1531346878377-a5be20888e57?w=500&h=500&fit=crop',
    description:
        'Set of 3 lined notebooks perfect for lectures, meetings, or journaling. 80 pages each.',
    category: ProductCategory.merchandise,
  ),
  Product(
    id: 'essentials-6',
    name: 'Water Bottle',
    price: 16.99,
    imageUrl:
        'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=500&h=500&fit=crop',
    description:
        'Stainless steel insulated water bottle. Keeps drinks cold for 24 hours or hot for 12 hours.',
    category: ProductCategory.merchandise,
    colors: ['Silver', 'Black', 'Blue', 'Pink'],
  ),
  Product(
    id: 'essentials-7',
    name: 'Backpack',
    price: 44.99,
    imageUrl:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500&h=500&fit=crop',
    description:
        'Versatile backpack with laptop compartment, multiple pockets, and padded straps for comfort.',
    category: ProductCategory.product,
    colors: ['Black', 'Grey', 'Navy'],
  ),
  Product(
    id: 'essentials-8',
    name: 'Pen Set',
    price: 8.99,
    imageUrl:
        'https://images.unsplash.com/photo-1585336261022-680e295ce3fe?w=500&h=500&fit=crop',
    description:
        'Premium ballpoint pen set with smooth ink flow. Includes 5 pens in assorted colours.',
    category: ProductCategory.merchandise,
  ),
  Product(
    id: 'essentials-9',
    name: 'Zip-Up Hoodie',
    price: 39.99,
    imageUrl:
        'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=500&h=500&fit=crop',
    description:
        'Full zip hoodie with front pockets. Easy to layer and perfect for unpredictable weather.',
    category: ProductCategory.product,
    colors: ['Grey', 'Black', 'Navy'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'essentials-10',
    name: 'Baseball Cap',
    price: 15.99,
    imageUrl:
        'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=500&h=500&fit=crop',
    description:
        'Classic baseball cap with adjustable strap. Protects from sun while looking stylish.',
    category: ProductCategory.product,
    colors: ['Black', 'Navy', 'White'],
  ),
  Product(
    id: 'essentials-11',
    name: 'Sweatpants',
    price: 32.99,
    imageUrl:
        'https://images.unsplash.com/photo-1552902865-b72c031ac5ea?w=500&h=500&fit=crop',
    description:
        'Comfortable jogger-style sweatpants with elastic cuffs and drawstring waist. Perfect for lounging or gym.',
    category: ProductCategory.product,
    colors: ['Grey', 'Black', 'Navy'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'essentials-12',
    name: 'Crew Neck Sweatshirt',
    price: 29.99,
    imageUrl:
        'https://images.unsplash.com/photo-1578768079052-aa76e52ff62e?w=500&h=500&fit=crop',
    description:
        'Classic crew neck sweatshirt in soft fleece. A timeless layering piece for any wardrobe.',
    category: ProductCategory.product,
    colors: ['Grey', 'Black', 'Navy', 'Burgundy'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'essentials-13',
    name: 'Umbrella',
    price: 18.99,
    imageUrl:
        'https://images.unsplash.com/photo-1534309466160-70b22cc6252c?w=500&h=500&fit=crop',
    description:
        'Compact folding umbrella with automatic open/close. Fits easily in your bag for rainy days.',
    category: ProductCategory.merchandise,
    colors: ['Black', 'Navy', 'Red'],
  ),
  Product(
    id: 'essentials-14',
    name: 'Mug',
    price: 9.99,
    imageUrl:
        'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=500&h=500&fit=crop',
    description:
        'Ceramic mug with university branding. Holds 350ml of your favourite hot beverage.',
    category: ProductCategory.merchandise,
    colors: ['White', 'Black'],
  ),
  Product(
    id: 'essentials-15',
    name: 'Beanie',
    price: 14.99,
    imageUrl:
        'https://images.unsplash.com/photo-1576871337622-98d48d1cf531?w=500&h=500&fit=crop',
    description:
        'Warm knitted beanie for cold days. One size fits most with stretchy ribbed design.',
    category: ProductCategory.product,
    colors: ['Black', 'Grey', 'Navy', 'Burgundy'],
  ),
];

// =============================================================================
// SUMMER SALE COLLECTION PRODUCTS
// =============================================================================

final List<Product> summerSaleProducts = [
  Product(
    id: 'summer-1',
    name: 'Retro Sunglasses',
    price: 24.99,
    discountedPrice: 14.99,
    imageUrl:
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500&h=500&fit=crop',
    description:
        'Stylish retro-inspired sunglasses with UV400 protection. Perfect for sunny days.',
    category: ProductCategory.product,
    colors: ['Black', 'Tortoise', 'Clear'],
  ),
  Product(
    id: 'summer-2',
    name: 'Straw Sun Hat',
    price: 22.99,
    discountedPrice: 12.99,
    imageUrl:
        'https://images.unsplash.com/photo-1521369909029-2afed882baee?w=500&h=500&fit=crop',
    description:
        'Wide-brim straw hat for maximum sun protection. Lightweight and breathable for hot days.',
    category: ProductCategory.product,
    colors: ['Natural', 'Black Trim', 'White Trim'],
  ),
  Product(
    id: 'summer-3',
    name: 'Beach Towel',
    price: 28.99,
    discountedPrice: 18.99,
    imageUrl:
        'https://images.unsplash.com/photo-1607799279861-4dd421887fb3?w=500&h=500&fit=crop',
    description:
        'Oversized beach towel made from quick-dry microfibre. Lightweight and sand-resistant.',
    category: ProductCategory.product,
    colors: ['Striped Blue', 'Tropical', 'Coral'],
  ),
  Product(
    id: 'summer-4',
    name: 'Flip Flops',
    price: 16.99,
    discountedPrice: 9.99,
    imageUrl:
        'https://images.unsplash.com/photo-1603487742131-4160ec999306?w=500&h=500&fit=crop',
    description:
        'Comfortable flip flops with cushioned soles. Perfect for the beach or poolside.',
    category: ProductCategory.product,
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'Navy', 'White'],
  ),
  Product(
    id: 'summer-5',
    name: 'Portable Fan',
    price: 12.99,
    discountedPrice: 7.99,
    imageUrl:
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500&h=500&fit=crop',
    description:
        'USB rechargeable mini fan with 3 speed settings. Stay cool anywhere you go.',
    category: ProductCategory.merchandise,
    colors: ['White', 'Pink', 'Blue'],
  ),
  Product(
    id: 'summer-6',
    name: 'Cooler Bag',
    price: 34.99,
    discountedPrice: 22.99,
    imageUrl:
        'https://images.unsplash.com/photo-1581888227599-779811939961?w=500&h=500&fit=crop',
    description:
        'Insulated cooler bag keeps drinks and snacks cold for hours. Perfect for picnics.',
    category: ProductCategory.product,
    colors: ['Navy', 'Grey', 'Red'],
  ),
];

// =============================================================================
// NEW ARRIVALS COLLECTION PRODUCTS
// =============================================================================

final List<Product> newArrivalsProducts = [
  Product(
    id: 'arrivals-1',
    name: 'Wireless Earbuds',
    price: 49.99,
    imageUrl:
        'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500&h=500&fit=crop',
    description:
        'True wireless earbuds with noise cancellation and 24-hour battery life. Crystal clear audio.',
    category: ProductCategory.product,
    colors: ['White', 'Black'],
  ),
  Product(
    id: 'arrivals-2',
    name: 'Desk Organiser',
    price: 19.99,
    imageUrl:
        'https://images.unsplash.com/photo-1507925921958-8a62f3d1a50d?w=500&h=500&fit=crop',
    description:
        'Minimalist desk organiser with compartments for pens, phone, and small items. Keep your workspace tidy.',
    category: ProductCategory.merchandise,
    colors: ['White', 'Black', 'Wood'],
  ),
  Product(
    id: 'arrivals-3',
    name: 'Laptop Sleeve',
    price: 29.99,
    imageUrl:
        'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500&h=500&fit=crop',
    description:
        'Padded laptop sleeve fits up to 15" laptops. Water-resistant exterior with soft fleece lining.',
    category: ProductCategory.product,
    colors: ['Grey', 'Navy', 'Black'],
  ),
  Product(
    id: 'arrivals-4',
    name: 'Motivational Poster Set',
    price: 24.99,
    imageUrl:
        'https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?w=500&h=500&fit=crop',
    description:
        'Set of 4 inspirational posters to brighten up your room or study space. A4 size, unframed.',
    category: ProductCategory.merchandise,
  ),
  Product(
    id: 'arrivals-5',
    name: 'Phone Stand',
    price: 14.99,
    imageUrl:
        'https://images.unsplash.com/photo-1586953208448-b95a79798f07?w=500&h=500&fit=crop',
    description:
        'Adjustable phone stand for hands-free viewing. Perfect for video calls and watching content.',
    category: ProductCategory.merchandise,
    colors: ['Silver', 'Black', 'Rose Gold'],
  ),
  Product(
    id: 'arrivals-6',
    name: 'LED Desk Lamp',
    price: 34.99,
    imageUrl:
        'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&h=500&fit=crop',
    description:
        'Adjustable LED desk lamp with multiple brightness levels and colour temperatures. USB charging port included.',
    category: ProductCategory.merchandise,
    colors: ['White', 'Black'],
  ),
  Product(
    id: 'arrivals-7',
    name: 'Wireless Charging Pad',
    price: 24.99,
    imageUrl:
        'https://images.unsplash.com/photo-1591815302525-756a9bcc3425?w=500&h=500&fit=crop',
    description:
        'Fast wireless charging pad compatible with all Qi-enabled devices. Sleek minimalist design.',
    category: ProductCategory.merchandise,
    colors: ['Black', 'White'],
  ),
  Product(
    id: 'arrivals-8',
    name: 'Bluetooth Speaker',
    price: 39.99,
    imageUrl:
        'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500&h=500&fit=crop',
    description:
        'Portable Bluetooth speaker with 360° sound. Waterproof design with 12-hour battery life.',
    category: ProductCategory.product,
    colors: ['Black', 'Blue', 'Red'],
  ),
];

// =============================================================================
// HOME PAGE PRODUCT LISTS (for display sections)
// =============================================================================

/// Products displayed in the Summer Range section on the home page.
final List<Product> summerRangeProducts = summerSaleProducts;

/// Products displayed in the Featured Collection section on the home page.
final List<Product> featuredCollectionProducts =
    essentialsProducts.take(4).toList();

/// Legacy sample products list (for backwards compatibility).
final List<Product> sampleProducts = essentialsProducts;
