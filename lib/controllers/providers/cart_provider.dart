import 'package:flutter/foundation.dart';
import '../../models/product_model.dart';

class CartItem {
  final ProductModel product;
  final int quantity;
  final String? size;
  final String? color;

  CartItem({
    required this.product,
    required this.quantity,
    this.size,
    this.color,
  });

  double get totalPrice =>
      (double.tryParse(product.price.toString()) ?? 0.0) * quantity;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get itemCount => _items.length;

  void addToCart(ProductModel product, int quantity,
      {String? size, String? color}) {
    // Check if item already exists with same size/color
    final index = _items.indexWhere((item) =>
        item.product.id == product.id &&
        item.size == size &&
        item.color == color);

    if (index >= 0) {
      // Update quantity
      final existing = _items[index];
      _items[index] = CartItem(
        product: existing.product,
        quantity: existing.quantity + quantity,
        size: existing.size,
        color: existing.color,
      );
    } else {
      // Add new item
      _items.add(CartItem(
        product: product,
        quantity: quantity,
        size: size,
        color: color,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      final item = _items[index];
      _items[index] = CartItem(
        product: item.product,
        quantity: item.quantity + 1,
        size: item.size,
        color: item.color,
      );
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      final item = _items[index];
      if (item.quantity > 1) {
        _items[index] = CartItem(
          product: item.product,
          quantity: item.quantity - 1,
          size: item.size,
          color: item.color,
        );
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
