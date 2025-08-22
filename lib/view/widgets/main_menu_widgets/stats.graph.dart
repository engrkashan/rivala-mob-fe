import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class LineGraph extends StatefulWidget {
  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  List<HeartRateData> chartData = [];
  List<String> xLabels = [];
  List<HeartRateData> chartData2 = [];

  @override
  void initState() {
    super.initState();
    chartData = getHeartRateData();
    chartData2 = getHeartRateData2();
    // Generate x-axis labels for the next 7 days
    final today = DateTime.now();
    xLabels = List.generate(7, (index) {
      final date = today.add(Duration(days: index));
      return DateFormat('dd MMM').format(date); // Example: '22 Nov'
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        isVisible: true, // Ensure x-axis is visible
        majorTickLines: MajorTickLines(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(color: kblack.withOpacity(0.4)),
        labelStyle: TextStyle(color: kblack),
        interval: 1,
        minimum: 1,
        maximum: 7, 
        axisLabelFormatter: (AxisLabelRenderDetails args) {
          // Formatting bottom labels as 1.0, 2.0, 3.0, etc.
          return ChartAxisLabel('${args.value.toStringAsFixed(1)}', TextStyle(color: kblack.withOpacity(0.5), fontSize: 10));
        },
      ),
      primaryYAxis: NumericAxis(
        minimum: 50,
        maximum: 180,
        interval: 20,
        isVisible: true,
      
        labelFormat: '{value} BPM',
        labelStyle: TextStyle(color: kblack2.withOpacity(0.5)),
axisLabelFormatter: (AxisLabelRenderDetails args) {
  final value = args.value.toInt();
  final timeLabels = [
    '\$50', '\$100', '\$150', '\$200', '\$250',
  ];

  // Adjust the index based on the interval of 30 (50, 80, 110, etc.)
  final index = ((value - 50) ~/ 30); 
  if (index >= 0 && index < timeLabels.length) {
    return ChartAxisLabel(timeLabels[index], TextStyle(color: kblack.withOpacity(0.5), fontSize: 10));
  }

  return ChartAxisLabel('', TextStyle(color: kblack));
},

        majorTickLines: MajorTickLines(width: 0),
        majorGridLines: MajorGridLines(width: 0.5),
        axisLine: AxisLine(color: Colors.transparent),
      ),
      series: <SplineAreaSeries<HeartRateData, double>>[
        // SplineAreaSeries<HeartRateData, double>(
        //   dataSource: chartData2,
        //   xValueMapper: (HeartRateData data, _) => data.time,
        //   yValueMapper: (HeartRateData data, _) => data.bpm + 10, // Adjust to position above the first series
        //   borderColor: ktransparent,
        //   borderWidth: 3,
        //   gradient: LinearGradient(
        //     colors: [Color(0xff52C08C),kwhite ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        //   splineType: SplineType.clamped,
        // ),
        SplineAreaSeries<HeartRateData, double>(
          dataSource: chartData,
          xValueMapper: (HeartRateData data, _) => data.time,
          yValueMapper: (HeartRateData data, _) => data.bpm,
          borderColor:Color(0xff52C08C),
               gradient: LinearGradient(
            colors: [Color(0xff52C08C),kwhite.withOpacity(0.08) ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0,1]
          ),
          splineType: SplineType.natural,
          borderWidth: 1.5, // Adjust the line width for a clearer appearance
        ),
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        borderWidth: 2,
        borderColor: Color(0xff52C08C)
      ),
    );
  }
}

class HeartRateData {
  final double time;
  final double bpm;
  HeartRateData(this.time, this.bpm);
}

List<HeartRateData> getHeartRateData() {
  return [
    HeartRateData(0, 80),
    HeartRateData(1, 105),
    HeartRateData(2, 110),
    HeartRateData(3, 95),
    HeartRateData(4, 70),
    HeartRateData(5, 105),
    HeartRateData(6, 105),
    HeartRateData(7, 110),
  ];
}

List<HeartRateData> getHeartRateData2() {
  return [
    HeartRateData(0, 130),
    HeartRateData(1, 100),
    HeartRateData(2, 140),
    HeartRateData(3, 80),
    HeartRateData(4, 85),
    HeartRateData(5, 100),
    HeartRateData(7, 130),
  ];
}
