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
