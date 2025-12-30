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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
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
                  MyText(
                    text:
                        'Last updated: ${DateFormat('MM/dd/yyyy').format(DateTime.now())}',
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

  double _calculateTotalCommission(List orders) {
    double total = 0;
    for (var order in orders) {
      if (order.orderItems != null) {
        for (var item in order.orderItems!) {
          total +=
              (item.price ?? 0) * (item.quantity ?? 0) * COMMISSION_PERCENTAGE;
        }
      }
    }
    return total;
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
