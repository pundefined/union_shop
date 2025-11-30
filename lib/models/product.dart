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
    imageUrl: 'assets/images/canvas_tote_bag.png',
    description:
        'Durable canvas tote bag perfect for carrying books, groceries, or everyday essentials. Features reinforced handles and a spacious interior.',
    category: ProductCategory.product,
    colors: ['Natural', 'Navy', 'Black'],
  ),
  Product(
    id: 'essentials-2',
    name: 'Classic Hoodie',
    price: 34.99,
    imageUrl: 'assets/images/classic_hoodie.png',
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
    imageUrl: 'assets/images/basic_tshirt.png',
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
    imageUrl: 'assets/images/lanyard_with_card_holder.png',
    description:
        'Convenient lanyard with detachable card holder. Keep your ID and cards easily accessible.',
    category: ProductCategory.merchandise,
    colors: ['Purple', 'Blue', 'Black'],
  ),
  Product(
    id: 'essentials-5',
    name: 'Notebook Set',
    price: 12.99,
    imageUrl: 'assets/images/notebook_set.png',
    description:
        'Set of 3 lined notebooks perfect for lectures, meetings, or journaling. 80 pages each.',
    category: ProductCategory.merchandise,
  ),
  Product(
    id: 'essentials-6',
    name: 'Water Bottle',
    price: 16.99,
    imageUrl: 'assets/images/water_bottle.png',
    description:
        'Stainless steel insulated water bottle. Keeps drinks cold for 24 hours or hot for 12 hours.',
    category: ProductCategory.merchandise,
    colors: ['Silver', 'Black', 'Blue', 'Pink'],
  ),
  Product(
    id: 'essentials-7',
    name: 'Backpack',
    price: 44.99,
    imageUrl: 'assets/images/backpack.png',
    description:
        'Versatile backpack with laptop compartment, multiple pockets, and padded straps for comfort.',
    category: ProductCategory.product,
    colors: ['Black', 'Grey', 'Navy'],
  ),
  Product(
    id: 'essentials-8',
    name: 'Pen Set',
    price: 8.99,
    imageUrl: 'assets/images/pen_set.png',
    description:
        'Premium ballpoint pen set with smooth ink flow. Includes 5 pens in assorted colours.',
    category: ProductCategory.merchandise,
  ),
  Product(
    id: 'essentials-9',
    name: 'Zip-Up Hoodie',
    price: 39.99,
    imageUrl: 'assets/images/zip_up_hoodie.png',
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
    imageUrl: 'assets/images/baseball_cap.png',
    description:
        'Classic baseball cap with adjustable strap. Protects from sun while looking stylish.',
    category: ProductCategory.product,
    colors: ['Black', 'Navy', 'White'],
  ),
  Product(
    id: 'essentials-11',
    name: 'Sweatpants',
    price: 32.99,
    imageUrl: 'assets/images/sweatpants.png',
    description:
        'Comfortable jogger-style sweatpants with elastic cuffs and drawstring waist. Perfect for lounging or gym.',
    category: ProductCategory.product,
    colors: ['Grey', 'Black', 'Navy'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'essentials-12',
    name: 'Umbrella',
    price: 18.99,
    imageUrl: 'assets/images/umbrella.png',
    description:
        'Compact folding umbrella with automatic open/close. Fits easily in your bag for rainy days.',
    category: ProductCategory.merchandise,
    colors: ['Black', 'Navy', 'Red'],
  ),
  Product(
    id: 'essentials-13',
    name: 'Mug',
    price: 9.99,
    imageUrl: 'assets/images/mug.png',
    description:
        'Ceramic mug with university branding. Holds 350ml of your favourite hot beverage.',
    category: ProductCategory.merchandise,
    colors: ['White', 'Black'],
  ),
  Product(
    id: 'essentials-14',
    name: 'Beanie',
    price: 14.99,
    imageUrl: 'assets/images/beanie.png',
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
// SIGNATURE RANGE COLLECTION PRODUCTS
// =============================================================================

final List<Product> signatureRangeProducts = [
  Product(
    id: 'signature-1',
    name: 'Premium Leather Jacket',
    price: 149.99,
    imageUrl:
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500&h=500&fit=crop',
    description:
        'Handcrafted leather jacket with university crest embossed on the back. A statement piece for any occasion.',
    category: ProductCategory.product,
    colors: ['Black', 'Brown'],
    sizes: ['S', 'M', 'L', 'XL'],
  ),
  Product(
    id: 'signature-2',
    name: 'Varsity Jacket',
    price: 89.99,
    imageUrl:
        'https://images.unsplash.com/photo-1559551409-dadc959f76b8?w=500&h=500&fit=crop',
    description:
        'Classic varsity jacket with chenille lettering and striped cuffs. Show your school pride in style.',
    category: ProductCategory.product,
    colors: ['Navy/White', 'Black/Gold', 'Burgundy/Grey'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'signature-3',
    name: 'Embroidered Polo Shirt',
    price: 44.99,
    imageUrl:
        'https://images.unsplash.com/photo-1625910513413-5fc45e14bb72?w=500&h=500&fit=crop',
    description:
        'Premium cotton polo with embroidered university logo. Smart casual style for any setting.',
    category: ProductCategory.product,
    colors: ['White', 'Navy', 'Black', 'Burgundy'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'signature-4',
    name: 'Cashmere Scarf',
    price: 59.99,
    imageUrl:
        'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?w=500&h=500&fit=crop',
    description:
        'Luxuriously soft cashmere blend scarf with subtle university pattern. Elegant warmth for colder months.',
    category: ProductCategory.product,
    colors: ['Navy', 'Grey', 'Burgundy'],
  ),
  Product(
    id: 'signature-5',
    name: 'Executive Pen',
    price: 34.99,
    imageUrl:
        'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500&h=500&fit=crop',
    description:
        'Premium metal ballpoint pen with engraved university name. Comes in a presentation gift box.',
    category: ProductCategory.merchandise,
    colors: ['Silver', 'Gold', 'Black'],
  ),
  Product(
    id: 'signature-6',
    name: 'Leather Messenger Bag',
    price: 119.99,
    imageUrl:
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=500&h=500&fit=crop',
    description:
        'Full grain leather messenger bag with brass hardware. Fits laptops up to 15" with multiple organiser pockets.',
    category: ProductCategory.product,
    colors: ['Tan', 'Dark Brown', 'Black'],
  ),
  Product(
    id: 'signature-7',
    name: 'Silk Tie',
    price: 39.99,
    imageUrl:
        'https://images.unsplash.com/photo-1598879423532-39e1e9f21d03?w=500&h=500&fit=crop',
    description:
        'Pure silk tie with woven university crest. Perfect for formal events and interviews.',
    category: ProductCategory.product,
    colors: ['Navy', 'Burgundy', 'Black'],
  ),
  Product(
    id: 'signature-8',
    name: 'Crystal Paperweight',
    price: 49.99,
    imageUrl:
        'https://images.unsplash.com/photo-1587467512961-120760940315?w=500&h=500&fit=crop',
    description:
        'Hand-cut crystal paperweight with laser-etched university crest. A timeless desk accessory.',
    category: ProductCategory.merchandise,
  ),
  Product(
    id: 'signature-10',
    name: 'Graduation Frame',
    price: 54.99,
    imageUrl:
        'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?w=500&h=500&fit=crop',
    description:
        'Elegant wooden frame with gold university seal. Display your degree with pride.',
    category: ProductCategory.merchandise,
    colors: ['Walnut', 'Black', 'Cherry'],
  ),
];

// =============================================================================
// WINTER FAVOURITES COLLECTION PRODUCTS
// =============================================================================

final List<Product> winterFavouritesProducts = [
  Product(
    id: 'winter-1',
    name: 'Puffer Jacket',
    price: 79.99,
    imageUrl:
        'https://images.unsplash.com/photo-1544923246-77307dd628b5?w=500&h=500&fit=crop',
    description:
        'Warm quilted puffer jacket with water-resistant shell. Hood included for extra protection.',
    category: ProductCategory.product,
    colors: ['Black', 'Navy', 'Burgundy'],
    sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  ),
  Product(
    id: 'winter-2',
    name: 'Fleece Lined Gloves',
    price: 19.99,
    imageUrl:
        'https://images.unsplash.com/photo-1545170241-dd2c92a11f53?w=500&h=500&fit=crop',
    description:
        'Touch-screen compatible gloves with soft fleece lining. Keep your hands warm while using your phone.',
    category: ProductCategory.product,
    colors: ['Black', 'Grey', 'Navy'],
    sizes: ['S/M', 'L/XL'],
  ),
  Product(
    id: 'winter-3',
    name: 'Thermal Socks Pack',
    price: 16.99,
    imageUrl:
        'https://images.unsplash.com/photo-1586350977771-b3b0abd50c82?w=500&h=500&fit=crop',
    description:
        'Pack of 3 thermal socks with extra cushioning. Keep your feet warm all winter long.',
    category: ProductCategory.product,
    sizes: ['4-7', '8-11'],
  ),
  Product(
    id: 'winter-4',
    name: 'Hot Chocolate Gift Set',
    price: 24.99,
    imageUrl:
        'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=500&h=500&fit=crop',
    description:
        'Luxury hot chocolate set with mug, marshmallows, and premium cocoa. Perfect winter warmer.',
    category: ProductCategory.merchandise,
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
