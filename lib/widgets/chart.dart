import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatelessWidget {
  final Map<ExpenceCategories, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  final bool isExpense;

  const Chart({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
    required this.isExpense,
  });

  @override
  Widget build(BuildContext context) {
    final data = isExpense ? expenseCategoryTotals : incomeCategoryTotals;
    
    if (data.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Text(
          'No data available',
          style: TextStyle(
            fontSize: 16,
            color: kGrey,
          ),
        ),
      );
    }

    List<PieChartSectionData> sections = [];
    int index = 0;
    final colors = [kMainColor, kGreen, kRed, Colors.orange, Colors.purple];
    
    data.forEach((category, amount) {
      final total = data.values.reduce((a, b) => a + b);
      final percentage = (amount / total * 100);
      
      sections.add(
        PieChartSectionData(
          color: colors[index % colors.length],
          value: percentage,
          title: '${percentage.toStringAsFixed(1)}%',
          radius: 100,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
        ),
      );
      index++;
    });

    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 40,
          sectionsSpace: 2,
        ),
      ),
    );
  }
}
