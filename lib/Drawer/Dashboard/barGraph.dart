import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatefulWidget {
  final List<Map<String, int>> recentSales;
  BarGraph({
    @required this.recentSales,
  });
  @override
  State<StatefulWidget> createState() => BarGraphState();
}

class BarGraphState extends State<BarGraph> {
  final now = DateTime.now();

  getDays(int weekday) {
    weekday = (weekday + 14) % 7;
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 0:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
//      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//      color: Color(0xff2c4260),
      color: Colors.white,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
//          maxY: 200,
          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              tooltipBgColor: Colors.green,
              tooltipPadding: const EdgeInsets.all(2),
              tooltipBottomMargin: 16,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  rod.y.round().toString(),
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              textStyle: TextStyle(
                  color: const Color(0xff7589a2),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
//                margin: 20,
              getTitles: (double value) {
                switch (value.toInt()) {
                  case 0:
                    return getDays(now.weekday - 7);
                  case 1:
                    return getDays(now.weekday - 6);
                  case 2:
                    return getDays(now.weekday - 5);
                  case 3:
                    return getDays(now.weekday - 4);
                  case 4:
                    return getDays(now.weekday - 3);
                  case 5:
                    return getDays(now.weekday - 2);
                  case 6:
                    return getDays(now.weekday - 1);
                  case 7:
                    return getDays(now.weekday);
                  default:
                    return '';
                }
              },
            ),
            leftTitles: SideTitles(showTitles: false),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  y: widget.recentSales[7]["totalAmount"].toDouble(),
                  color: Colors.lightBlueAccent)
            ], showingTooltipIndicators: [
              0
            ]),
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  y: widget.recentSales[6]["totalAmount"].toDouble(),
                  color: Colors.lightBlueAccent)
            ], showingTooltipIndicators: [
              0
            ]),
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  y: widget.recentSales[5]["totalAmount"].toDouble(),
                  color: Colors.lightBlueAccent)
            ], showingTooltipIndicators: [
              0
            ]),
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  y: widget.recentSales[4]["totalAmount"].toDouble(),
                  color: Colors.lightBlueAccent)
            ], showingTooltipIndicators: [
              0
            ]),
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  y: widget.recentSales[3]["totalAmount"].toDouble(),
                  color: Colors.lightBlueAccent)
            ], showingTooltipIndicators: [
              0
            ]),
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  y: widget.recentSales[2]["totalAmount"].toDouble(),
                  color: Colors.lightBlueAccent)
            ], showingTooltipIndicators: [
              0
            ]),
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  y: widget.recentSales[1]["totalAmount"].toDouble(),
                  color: Colors.lightBlueAccent)
            ], showingTooltipIndicators: [
              0
            ]),

            // today's data
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  y: widget.recentSales[0]["totalAmount"].toDouble(),
                  color: Colors.lightBlueAccent)
            ], showingTooltipIndicators: [
              0
            ]),
          ],
        ),
      ),
    );
  }
}
