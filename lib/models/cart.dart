import 'package:flutter/foundation.dart';
import 'product.dart';

// Represents an item in the shopping cart with product details and quantity.
class CartItem {
  final Product product;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;

  const CartItem({
    required this.product,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
  });

  // Creates a copy of this CartItem with optional new values.
  CartItem copyWith({
    Product? product,
    int? quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }

  // Calculates the total price for this cart item.
  double get totalPrice {
    final unitPrice = product.discountedPrice ?? product.price;
    return unitPrice * quantity;
  }

  // Unique key combining product ID and variant selections.
  String get uniqueKey {
    return '${product.id}_${selectedColor ?? ''}_${selectedSize ?? ''}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.product.id == product.id &&
        other.selectedColor == selectedColor &&
        other.selectedSize == selectedSize;
  }

  @override
  int get hashCode =>
      product.id.hashCode ^ selectedColor.hashCode ^ selectedSize.hashCode;
}

// Provider that manages the shopping cart state during the session.
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  // Returns the total number of items in the cart.
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  // Returns the total price of all items in the cart.
  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Returns true if the cart is empty.
  bool get isEmpty => _items.isEmpty;

  // Returns true if the cart has items.
  bool get isNotEmpty => _items.isNotEmpty;

  /// Adds a product to the cart with the specified quantity and variant options.
  /// If the same product with the same variants already exists, increases quantity.
  void addItem({
    required Product product,
    required int quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    final newItem = CartItem(
      product: product,
      quantity: quantity,
      selectedColor: selectedColor,
      selectedSize: selectedSize,
    );

    final existingIndex = _items.indexWhere(
      (item) => item.uniqueKey == newItem.uniqueKey,
    );

    if (existingIndex >= 0) {
      // Update existing item quantity
      final existingItem = _items[existingIndex];
      _items[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    } else {
      // Add new item
      _items.add(newItem);
    }

    notifyListeners();
  }

  /// Removes an item from the cart by its unique key.
  void removeItem(String uniqueKey) {
    _items.removeWhere((item) => item.uniqueKey == uniqueKey);
    notifyListeners();
  }

  /// Updates the quantity of an item in the cart.
  void updateQuantity(String uniqueKey, int newQuantity) {
    if (newQuantity < 1) {
      removeItem(uniqueKey);
      return;
    }

    final index = _items.indexWhere((item) => item.uniqueKey == uniqueKey);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
