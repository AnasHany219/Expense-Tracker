// ignore_for_file: unused_local_variable

import 'package:expense_tracker/core/text_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A widget representing a pie chart and a line chart displaying expense summary.
class ExpenseSummaryCharts extends StatelessWidget {
  /// The expense data to be visualized in the charts.
  final Map<String, double> expenseData;

  /// Constructs a new [ExpenseSummaryCharts] instance.
  const ExpenseSummaryCharts({super.key, required this.expenseData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Expense Summary Title
        _title('Expense Summary', context),
        const SizedBox(height: 30),

        /// Pie Chart
        _title('Pie Chart', context),
        _buildPieChart(context),
        const SizedBox(height: 30),

        /// Line Chart
        _title('Line Chart', context),
        _buildLineChart(context),
        const SizedBox(height: 30),
      ],
    );
  }

  /// Builds a title for the chart.
  Widget _title(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  /// Builds the pie chart.
  Widget _buildPieChart(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
          sections: _generatePieChartSections(context),
          centerSpaceRadius: 30.0,
        ),
      ),
    );
  }

  /// Builds the line chart.
  Widget _buildLineChart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: SizedBox(
        height: 300,
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    width: 3),
                bottom: BorderSide(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    width: 3),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: _generateLineChartSpots(),
                isCurved: true,
                color: Colors.blue,
                belowBarData: BarAreaData(
                  show: true,
                ),
              ),
            ],
            titlesData: FlTitlesData(
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: (value, meta) =>
                      _bottomTitleWidgets(value, meta, context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Generates pie chart sections from expense data.
  List<PieChartSectionData> _generatePieChartSections(BuildContext context) {
    final List<PieChartSectionData> sections = [];
    int index = 0;
    for (final entry in expenseData.entries) {
      final category = entry.key;
      final amount = entry.value;
      sections.add(PieChartSectionData(
        color: _randomColor(),
        value: amount,
        title: category,
        radius: 100,
        titleStyle: Theme.of(context).textTheme.bodyMedium,
      ));
      index++;
    }
    return sections;
  }

  /// Generates spots for the line chart.
  List<FlSpot> _generateLineChartSpots() {
    final List<FlSpot> spots = [];
    int index = 0;
    for (final entry in expenseData.entries) {
      final amount = entry.value;
      spots.add(FlSpot(index.toDouble(), amount));
      index++;
    }
    return spots;
  }

  /// Generates widgets for bottom titles on the line chart.
  Widget _bottomTitleWidgets(
      double value, TitleMeta meta, BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;

    final int index = value.toInt();
    final String categoryName = (index >= 0 && index < expenseData.length)
        ? expenseData.keys.elementAt(index)
        : '';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 40),
        child: Text(
          categoryName,
          style: style,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  /// Generates a random color.
  Color _randomColor() {
    return Color((math.Random().nextDouble() * 0x777777).toInt())
        .withOpacity(0.9);
  }
}
