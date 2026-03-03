import 'package:flutter/foundation.dart';
import 'package:rivala/models/product_model.dart';

import '../../models/cart_model.dart';
import '../repos/cart_local_storage.dart';

class CartProvider extends ChangeNotifier {
  final cartLocalStorage = CartLocalStorage();
  String? _selectedCard;

  String? get selectedCard => _selectedCard;
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  Future<void> loadCart() async {
    _items = await cartLocalStorage.getCart();
    notifyListeners();
  }

  Future<void> addToCart(CartItem item) async {
    final index = _items.indexWhere((p) => p.product.id == item.product.id);
    if (index >= 0) {
      _items[index] = CartItem(
          product: ProductModel(
            id: item.product.id,
            title: item.product.title,
            price: item.product.price,
          ),
          quantity: _items[index].quantity + 1);
    } else {
      _items.add(item);
    }

    await cartLocalStorage.saveCart(_items);
    print("added product: $item");
    notifyListeners();
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get itemCount => _items.length;

  Future<void> removeFromCart(String productId) async {
    _items.removeWhere(
      (item) => item.product.id == productId,
    );

    await cartLocalStorage.saveCart(_items);
    notifyListeners();
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

  Future<void> saveCard(String card) async {
    _selectedCard = card;
    await cartLocalStorage.setCard(card);
    notifyListeners();
  }

  Future<void> getCard() async {
    _selectedCard = await cartLocalStorage.getCard();
    notifyListeners();
  }
}
