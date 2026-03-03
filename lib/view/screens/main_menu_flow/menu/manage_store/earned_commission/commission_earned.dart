import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/revenue_provider.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../../models/revenue.dart';
import '../../../../master_flow/new_post/add_promo/search_criteria_products.dart';

const double COMMISSION_PERCENTAGE = 0.1; // 10% commission

class CommissionEarned extends StatefulWidget {
  final String? title;
  final bool? hascart;
  const CommissionEarned({super.key, this.title, this.hascart = false});

  @override
  State<CommissionEarned> createState() => _CommissionEarnedState();
}

class _CommissionEarnedState extends State<CommissionEarned> {
  int selectedDateIndex = 0;
  DateTimeRange? customDateRange;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RevenueProvider>().fetchRevenue();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RevenueProvider>();
    final revenue = provider.revenueResponse;

    // Calculate total commission for top display
    // final totalCommission = _calculateTotalCommission(revenue.);

    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: widget.title ?? 'Commissions Earned',
        centerTitle: true,
        size: 18,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (provider.isLoading)
            Expanded(child: Center(child: CircularProgressIndicator()))
          else if (provider.error != null && provider.error!.isNotEmpty)
            Expanded(
                child: Center(
                    child: Text('Error: ${provider.error}',
                        style: TextStyle(color: Colors.red))))
          else
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.hascart == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: widget.title ?? 'Commissions Paid',
                            size: 22,
                            color: kblack,
                            weight: FontWeight.w600,
                          ),
                          circular_icon_container(
                            size: 45,
                            iconSize: 22,
                          ),
                        ],
                      ),
                    MyGradientText(
                      text:
                          '\$${revenue?.summary.totalRevenue.toStringAsFixed(2) ?? '0.00'}',
                      size: 35,
                      weight: FontWeight.w600,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Earned',
                            revenue?.summary.earnedRevenue ?? 0.0,
                            Colors.green.withOpacity(0.1),
                            Colors.green,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: _buildSummaryCard(
                            'Pending',
                            revenue?.summary.pendingRevenue ?? 0.0,
                            Colors.orange.withOpacity(0.1),
                            Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Add Key here
                    CustomDateSelector(
                      key: ValueKey('customDateSelector'),
                      selectedIndex: selectedDateIndex,
                      onChanged: (index, range) {
                        setState(() {
                          selectedDateIndex = index;
                          customDateRange = range;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        row_widget(
                          onTap: () {
                            Get.bottomSheet(
                              SearchCriteriaProducts(hasCheckbox: false),
                              isScrollControlled: true,
                            );
                          },
                          icon: Assets.imagesFilter,
                          iconSize: 18,
                          texSize: 13,
                          title: 'Filter report',
                        ),
                        row_widget(
                          icon: Assets.imagesCsv,
                          iconSize: 18,
                          texSize: 13,
                          title: 'CSV Export',
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Add Key here
                    LineGraph(
                      key: ValueKey(
                          'lineGraph_${selectedDateIndex}_${customDateRange?.start.toString()}'),
                      graph: revenue?.graph ?? [],
                    ),
                    if (revenue != null && revenue.orders.isNotEmpty) ...[
                      SizedBox(height: 20),
                      MyText(
                        text: "Recent Orders",
                        size: 18,
                        weight: FontWeight.w600,
                        paddingBottom: 15,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: revenue.orders.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          return _buildOrderCard(revenue.orders[index]);
                        },
                      ),
                    ],
                    SizedBox(height: 20),
                    MyText(
                      text:
                          'Last updated: ${DateFormat('MM/dd/yyyy').format(revenue?.summary.lastUpdated ?? DateTime.now())}',
                      size: 11,
                      color: kblack.withOpacity(0.5),
                      paddingBottom: 20,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, double amount, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: title,
            size: 12,
            color: kblack.withOpacity(0.6),
            weight: FontWeight.w500,
          ),
          SizedBox(height: 5),
          MyText(
            text: '\$${amount.toStringAsFixed(2)}',
            size: 18,
            color: textColor,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(RevenueOrder order) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kwhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kblack.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: kblack.withOpacity(0.02),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: order.id, // Order ID/Number
                size: 14,
                weight: FontWeight.bold,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: MyText(
                  text: order.status,
                  size: 10,
                  color: _getStatusColor(order.status),
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Divider(height: 20, color: kblack.withOpacity(0.05)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: order.customer,
                    size: 12,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(height: 2),
                  MyText(
                    text: DateFormat('MMM dd, yyyy').format(order.createdAt),
                    size: 10,
                    color: kblack.withOpacity(0.5),
                  ),
                ],
              ),
              MyText(
                text: '\$${order.totalAmount.toStringAsFixed(2)}',
                size: 14,
                weight: FontWeight.bold,
                color: kgreen2,
              ),
            ],
          ),
          if (order.products.isNotEmpty) ...[
            SizedBox(height: 8),
            MyText(
              text:
                  '${order.products.length} item(s): ${order.products.map((e) => e.title).join(", ")}',
              size: 11,
              color: kblack.withOpacity(0.6),
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
      case 'PAID':
        return Colors.green;
      case 'PENDING':
      case 'PROCESSING':
        return Colors.orange;
      case 'CANCELLED':
        return Colors.red;
      default:
        return kblack;
    }
  }
}

/// Custom Date Selector
class CustomDateSelector extends StatefulWidget {
  final int selectedIndex;
  final Function(int, DateTimeRange?) onChanged;

  const CustomDateSelector(
      {super.key, required this.selectedIndex, required this.onChanged});

  @override
  State<CustomDateSelector> createState() => _CustomDateSelectorState();
}

class _CustomDateSelectorState extends State<CustomDateSelector> {
  int selectedIndex = 0;
  DateTimeRange? customRange;

  final List<String> options = ["24 HOURS", "7 DAYS", "30 DAYS", "CUSTOM DATE"];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      vpad: 3,
      hpad: 5,
      radius: 8,
      color: ktertiary.withOpacity(0.2),
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(options.length, (index) {
          bool isSelected = selectedIndex == index;
          return Expanded(
            key: ValueKey('dateOption_$index'),
            child: GestureDetector(
              onTap: () async {
                DateTimeRange? range;
                if (index == 3) {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now(),
                  );
                  range = picked;
                }
                setState(() {
                  selectedIndex = index;
                  customRange = range;
                });
                widget.onChanged(index, range);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                decoration: BoxDecoration(
                  color: isSelected ? kwhite : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: MyText(
                    text: options[index],
                    textOverflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    size: 11,
                    color: isSelected ? kblack : kblack.withOpacity(0.7),
                    weight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Commission Data Model
class CommissionData {
  final double x; // numeric index
  final double commission; // y-axis
  CommissionData(this.x, this.commission);
}

/// Dynamic LineGraph Widget
class LineGraph extends StatelessWidget {
  final List<RevenueGraph> graph;

  const LineGraph({
    super.key,
    required this.graph,
  });

  @override
  Widget build(BuildContext context) {
    if (graph.isEmpty) {
      return const SizedBox(height: 200);
    }

    final maxY =
        graph.map((e) => e.revenue).reduce((a, b) => a > b ? a : b) * 1.2;

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorTickLines: const MajorTickLines(width: 0),
        axisLine: AxisLine(color: kblack.withOpacity(0.4)),
        labelStyle: const TextStyle(fontSize: 10),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: maxY == 0 ? 100 : maxY,
        interval: maxY / 5,
        labelFormat: '\${value}',
        majorGridLines: const MajorGridLines(width: 0.5),
      ),
      series: <SplineAreaSeries<RevenueGraph, String>>[
        SplineAreaSeries<RevenueGraph, String>(
          dataSource: graph,
          xValueMapper: (data, _) => DateFormat('dd MMM').format(data.date),
          yValueMapper: (data, _) => data.revenue,
          borderColor: const Color(0xff52C08C),
          borderWidth: 1.5,
          gradient: LinearGradient(
            colors: [const Color(0xff52C08C), kwhite.withOpacity(0.08)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          splineType: SplineType.natural,
        ),
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        borderColor: const Color(0xff52C08C),
      ),
    );
  }
}
