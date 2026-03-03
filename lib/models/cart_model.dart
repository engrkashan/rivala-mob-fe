import 'package:rivala/models/product_model.dart';

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

  double get totalPrice {
    final price = double.tryParse(product.price.toString()) ?? 0.0;
    return price * quantity;
  }

  /// Serialize CartItem → Map
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }

  /// Deserialize Map → CartItem
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(
        json['product'] as Map<String, dynamic>,
      ),
      quantity: json['quantity'] as int,
      size: json['size'] as String?,
      color: json['color'] as String?,
    );
  }

  /// Optional but powerful: immutable updates
  CartItem copyWith({
    ProductModel? product,
    int? quantity,
    String? size,
    String? color,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }
}
