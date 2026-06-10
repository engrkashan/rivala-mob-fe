import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/order_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/order_model.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/orders/order_detail_view.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:shimmer/shimmer.dart';

class MyOrders extends StatefulWidget {
  String? orderId;
  MyOrders({super.key, this.orderId});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final _searchCon = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Matches web: dispatch(listBuyerOrders())
      context.read<OrderProvider>().loadBuyerOrders();
    });
  }

  @override
  void dispose() {
    _searchCon.dispose();
    super.dispose();
  }

  /// Filter logic matches web:
  /// idHit || statusHit || productHit
  List<OrderModel> _filterOrders(List<OrderModel> orders) {
    if (_searchQuery.trim().isEmpty) return orders;
    final term = _searchQuery.toLowerCase();
    return orders.where((o) {
      final idHit = (o.id ?? '').toLowerCase().contains(term) ||
          (o.orderNumber ?? '').toLowerCase().contains(term);
      final statusHit = (o.status ?? '').toLowerCase().contains(term);
      final productHit = (o.orderItems ?? []).any((item) =>
          (item.product?.title ?? '').toLowerCase().contains(term));
      return idHit || statusHit || productHit;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
          context: context, title: 'My Orders', centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
            child: MyTextField(
              controller: _searchCon,
              hint: 'Search by order ID, product, or status',
              prefixIcon: Image.asset(Assets.imagesSearch, width: 12),
              onChanged: (val) {
                setState(() => _searchQuery = val);
              },
            ),
          ),
          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, orderProvider, _) {
                // Loading skeleton
                if (orderProvider.isLoading &&
                    orderProvider.buyerOrders.isEmpty) {
                  return _buildSkeleton();
                }

                final filtered =
                    _filterOrders(orderProvider.buyerOrders);

                // Empty state
                if (filtered.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_bag_outlined,
                              size: 60, color: kgrey2),
                          const SizedBox(height: 16),
                          MyText(
                            text: _searchQuery.isEmpty
                                ? "You don't have any orders yet."
                                : 'No orders match "$_searchQuery"',
                            size: 15,
                            color: ktertiary,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22, vertical: 8),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = filtered[index];
                    return _OrderCard(
                      order: order,
                      onTap: () => Navigator.of(context).push(
                        CustomPageRoute(
                            page: OrderDetailView(order: order)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: Platform.isIOS ? 40 : 20),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

/// Order card widget — mirrors web's OrdersCard
class _OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;

  const _OrderCard({required this.order, this.onTap});

  Color _statusColor(String? status) {
    switch ((status ?? '').toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'shipped':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      default:
        return ktertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = order.orderItems?.length ?? 0;
    final firstProduct = order.orderItems?.firstOrNull?.product;
    final total = order.payment?.amount;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kgrey2.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID + Status
            ExpandedRow(
              text1: order.orderNumber ??
                  '#${(order.id ?? '').substring(0, 8)}',
              text2: order.status ?? 'Pending',
              size1: 14,
              size2: 12,
              weight1: FontWeight.bold,
              color2: _statusColor(order.status),
              weight2: FontWeight.w600,
              useCustomFont: true,
            ),
            const SizedBox(height: 8),
            // Date
            if (order.createdAt != null)
              MyText(
                text: order.createdAt!
                    .toIso8601String()
                    .split('T')
                    .first,
                size: 12,
                color: ktertiary,
              ),
            const SizedBox(height: 8),
            // First product preview
            if (firstProduct != null)
              MyText(
                text: firstProduct.title ?? 'Product',
                size: 13,
                color: kdargrey,
                weight: FontWeight.w500,
              ),
            if (itemCount > 1)
              MyText(
                text: '+${itemCount - 1} more item${itemCount - 1 > 1 ? 's' : ''}',
                size: 12,
                color: ktertiary,
              ),
            const SizedBox(height: 8),
            // Total
            if (total != null)
              Align(
                alignment: Alignment.centerRight,
                child: MyText(
                  text: '\$${total.toStringAsFixed(2)}',
                  size: 15,
                  weight: FontWeight.bold,
                  color: kblack,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
