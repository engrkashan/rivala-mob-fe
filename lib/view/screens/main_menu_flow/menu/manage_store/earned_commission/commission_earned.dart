import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../controllers/providers/order_provider.dart';
import '../../../../../../generated/assets.dart';
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
      context.read<OrderProvider>().loadStoreOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders ?? [];

    // Calculate total commission for top display
    final totalCommission = _calculateTotalCommission(orders);

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
                    text: '\$${totalCommission.toStringAsFixed(2)}',
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
                    orders: orders,
                    dateFilterIndex: selectedDateIndex,
                    customRange: customDateRange,
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
  final List orders;
  final int dateFilterIndex; // 0:24H, 1:7D, 2:30D, 3:Custom
  final DateTimeRange? customRange;

  LineGraph(
      {super.key,
      required this.orders,
      required this.dateFilterIndex,
      this.customRange});

  @override
  Widget build(BuildContext context) {
    final aggregated = _aggregateCommission();

    double maxY = aggregated
        .map((e) => e.commission)
        .fold(0.0, (prev, val) => val > prev ? val : prev);
    maxY = maxY == 0 ? 100 : maxY * 1.2;

    List<String> xLabels = aggregated.map((e) => _formatXLabel(e.x)).toList();

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        minimum: 0,
        maximum: aggregated.length.toDouble() - 1,
        interval: 1,
        majorTickLines: MajorTickLines(width: 0),
        axisLine: AxisLine(color: kblack.withOpacity(0.4)),
        labelStyle: TextStyle(color: kblack),
        axisLabelFormatter: (args) {
          int idx = args.value.toInt();
          if (idx >= 0 && idx < xLabels.length) {
            return ChartAxisLabel(xLabels[idx],
                TextStyle(color: kblack.withOpacity(0.7), fontSize: 10));
          }
          return ChartAxisLabel('', TextStyle(color: kblack));
        },
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: maxY,
        interval: maxY / 5,
        majorGridLines: MajorGridLines(width: 0.5),
        labelStyle: TextStyle(color: kblack.withOpacity(0.5)),
        axisLine: AxisLine(color: Colors.transparent),
        labelFormat: '\${value}',
      ),
      series: <SplineAreaSeries<CommissionData, double>>[
        SplineAreaSeries<CommissionData, double>(
          dataSource: aggregated,
          xValueMapper: (data, _) => data.x,
          yValueMapper: (data, _) => data.commission,
          borderColor: Color(0xff52C08C),
          borderWidth: 1.5,
          gradient: LinearGradient(
            colors: [Color(0xff52C08C), kwhite.withOpacity(0.08)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          splineType: SplineType.natural,
        ),
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        borderWidth: 2,
        borderColor: Color(0xff52C08C),
      ),
    );
  }

  List<CommissionData> _aggregateCommission() {
    DateTime now = DateTime.now();
    DateTime start, end;

    switch (dateFilterIndex) {
      case 0: // 24 HOURS
        start = now.subtract(Duration(hours: 24));
        end = now;
        return _aggregateHourly(start, end);
      case 1: // 7 DAYS
        start = now.subtract(Duration(days: 7));
        end = now;
        return _aggregateDaily(start, end);
      case 2: // 30 DAYS
        start = now.subtract(Duration(days: 30));
        end = now;
        return _aggregateDaily(start, end);
      case 3: // CUSTOM
        start = customRange?.start ?? now.subtract(Duration(days: 7));
        end = customRange?.end ?? now;
        if (end.difference(start).inDays <= 1) {
          return _aggregateHourly(start, end);
        } else {
          return _aggregateDaily(start, end);
        }
      default:
        start = now.subtract(Duration(days: 7));
        end = now;
        return _aggregateDaily(start, end);
    }
  }

  List<CommissionData> _aggregateHourly(DateTime start, DateTime end) {
    List<CommissionData> result = [];
    int hours = end.difference(start).inHours;
    for (int i = 0; i <= hours; i++) {
      DateTime slotStart = start.add(Duration(hours: i));
      DateTime slotEnd = slotStart.add(Duration(hours: 1));
      double total = _calculateCommissionForRange(slotStart, slotEnd);
      result.add(CommissionData(i.toDouble(), total));
    }
    return result;
  }

  List<CommissionData> _aggregateDaily(DateTime start, DateTime end) {
    List<CommissionData> result = [];
    int days = end.difference(start).inDays;
    for (int i = 0; i <= days; i++) {
      DateTime slotStart = start.add(Duration(days: i));
      DateTime slotEnd = slotStart.add(Duration(days: 1));
      double total = _calculateCommissionForRange(slotStart, slotEnd);
      result.add(CommissionData(i.toDouble(), total));
    }
    return result;
  }

  double _calculateCommissionForRange(DateTime start, DateTime end) {
    double total = 0;
    for (var order in orders) {
      if (order.createdAt != null &&
          order.createdAt!.isAfter(start.subtract(Duration(seconds: 1))) &&
          order.createdAt!.isBefore(end)) {
        if (order.ordersItem != null) {
          for (var item in order.ordersItem!) {
            total += (item.price ?? 0) *
                (item.quantity ?? 0) *
                COMMISSION_PERCENTAGE;
          }
        }
      }
    }
    return total;
  }

  String _formatXLabel(double index) {
    DateTime now = DateTime.now();
    switch (dateFilterIndex) {
      case 0: // 24 HOURS
        DateTime labelTime =
            now.subtract(Duration(hours: (24 - index.toInt())));
        return DateFormat('ha').format(labelTime);
      case 1: // 7 DAYS
        DateTime labelTime = now.subtract(Duration(days: 6 - index.toInt()));
        return DateFormat('dd MMM').format(labelTime);
      case 2: // 30 DAYS
        DateTime labelTime = now.subtract(Duration(days: 29 - index.toInt()));
        return DateFormat('dd MMM').format(labelTime);
      case 3: // CUSTOM
        if (customRange != null) {
          int totalDays = customRange!.duration.inDays;
          DateTime labelTime =
              customRange!.start.add(Duration(days: index.toInt()));
          return DateFormat('dd MMM').format(labelTime);
        }
        return '';
      default:
        return '';
    }
  }
}
