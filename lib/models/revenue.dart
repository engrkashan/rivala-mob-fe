import 'package:rivala/models/order_model.dart';
import 'package:rivala/models/store_model.dart';

class RevenueResponse {
  final StoreModel store;
  final RevenueSummary summary;
  final List<RevenueGraph> graph;
  final List<OrderModel> orders;

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
      orders:
          (json['orders'] as List).map((e) => OrderModel.fromJson(e)).toList(),
    );
  }
}

class RevenueSummary {
  final double totalRevenue;
  final double pendingRevenue;
  final DateTime lastUpdated;

  RevenueSummary({
    required this.totalRevenue,
    required this.pendingRevenue,
    required this.lastUpdated,
  });

  factory RevenueSummary.fromJson(Map<String, dynamic> json) {
    return RevenueSummary(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      pendingRevenue: (json['pendingRevenue'] as num).toDouble(),
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
