import 'package:rivala/models/store_model.dart';

class RevenueResponse {
  final StoreModel store;
  final RevenueSummary summary;
  final List<RevenueGraph> graph;
  final List<RevenueOrder> orders;

  RevenueResponse({
    required this.store,
    required this.summary,
    required this.graph,
    required this.orders,
  });

  factory RevenueResponse.fromJson(Map<String, dynamic> json) {
    return RevenueResponse(
      store: StoreModel.fromJson(json['store']),
      summary: RevenueSummary.fromJson(json['summary']),
      graph:
          (json['graph'] as List).map((e) => RevenueGraph.fromJson(e)).toList(),
      orders: (json['orders'] as List?)
              ?.map((e) => RevenueOrder.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class RevenueSummary {
  final double totalRevenue;
  final double pendingRevenue;
  final double earnedRevenue; // Added earnedRevenue
  final DateTime lastUpdated;

  RevenueSummary({
    required this.totalRevenue,
    required this.pendingRevenue,
    required this.earnedRevenue,
    required this.lastUpdated,
  });

  factory RevenueSummary.fromJson(Map<String, dynamic> json) {
    return RevenueSummary(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      pendingRevenue: (json['pendingRevenue'] as num).toDouble(),
      earnedRevenue: (json['earnedRevenue'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}

class RevenueGraph {
  final DateTime date;
  final double revenue;

  RevenueGraph({
    required this.date,
    required this.revenue,
  });

  factory RevenueGraph.fromJson(Map<String, dynamic> json) {
    return RevenueGraph(
      date: DateTime.parse(json['date']),
      revenue: (json['revenue'] as num).toDouble(),
    );
  }
}

class RevenueOrder {
  final String id;
  final double totalAmount;
  final String status;
  final String customer;
  final String? avatar;
  final DateTime createdAt;
  final List<RevenueProduct> products;

  RevenueOrder({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.customer,
    this.avatar,
    required this.createdAt,
    required this.products,
  });

  factory RevenueOrder.fromJson(Map<String, dynamic> json) {
    print("Parsing RevenueOrder: $json");
    try {
      return RevenueOrder(
        id: json['id']?.toString() ?? '',
        totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
        status: json['status']?.toString() ?? 'UNKNOWN',
        customer: json['customer']?.toString() ?? 'Unknown',
        avatar: json['avatar']?.toString(), // nullable
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
        products: (json['products'] as List?)
                ?.map((e) => RevenueProduct.fromJson(e))
                .toList() ??
            [],
      );
    } catch (e) {
      print("Error parsing RevenueOrder: $e");
      rethrow;
    }
  }
}

class RevenueProduct {
  final String id;
  final String title;
  final double price;
  final int quantity;

  RevenueProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });

  factory RevenueProduct.fromJson(Map<String, dynamic> json) {
    return RevenueProduct(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }
}
