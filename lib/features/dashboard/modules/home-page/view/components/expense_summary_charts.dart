import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A widget representing a pie chart displaying expense summary.
class ExpenseSummaryCharts extends StatelessWidget {
  /// The expense data to be visualized in the pie chart.
  final Map<String, double> expenseData;

  /// Constructs a new [ExpenseSummaryCharts] instance.
  const ExpenseSummaryCharts({super.key, required this.expenseData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Expense Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 300,
          child: PieChart(
            PieChartData(
              sections: _generateSections(),
              centerSpaceRadius: 30.0,
            ),
          ),
        ),
      ],
    );
  }

  /// Generates pie chart sections from expense data.
  List<PieChartSectionData> _generateSections() {
    List<PieChartSectionData> sections = [];
    expenseData.forEach((category, amount) {
      sections.add(PieChartSectionData(
        color: _randomColor(),
        value: amount,
        title: category,
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ));
    });
    return sections;
  }

  /// Generates a random color.
  Color _randomColor() {
    return Color((math.Random().nextDouble() * 0x777777).toInt())
        .withOpacity(0.9);
  }
}
