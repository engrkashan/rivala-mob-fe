import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartLocalStorage {
  static const _cartKey = "cart_products";

  Future<void> saveCart(List<CartItem> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartList = cart.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_cartKey, cartList);
  }

  Future<List<CartItem>> getCart() async {
    final pref = await SharedPreferences.getInstance();
    final cartList = pref.getStringList(_cartKey);
    if (cartList == null) return [];

    return cartList
        .map((jsonStr) => CartItem.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  Future<void> clearChat() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  Future<void> setCard(String card) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("card", card);
  }

  Future<String?> getCard() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("card");
  }
}
