import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExpenseSummaryCharts extends StatelessWidget {
  final Map<String, double> expenseData;

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

  List<PieChartSectionData> _generateSections() {
    List<PieChartSectionData> sections = [];
    expenseData.forEach((category, amount) {
      sections.add(PieChartSectionData(
        color: _randomColor(),
        value: amount,
        title: category,
        radius: 100,
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ));
    });
    return sections;
  }

  Color _randomColor() {
    return Color((math.Random().nextDouble() * 0x777777).toInt())
        .withOpacity(0.9);
  }
}
