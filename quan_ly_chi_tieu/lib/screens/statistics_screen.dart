import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    double totalExpenses = expenseProvider.expenses.fold(0, (sum, item) => sum + item.amount);
    Map<String, double> weeklyExpenses = {};

    for (var expense in expenseProvider.expenses) {
      String week = 'Tuần ${expense.date.weekday}';
      weeklyExpenses[week] = (weeklyExpenses[week] ?? 0) + expense.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Thống kê Chi tiêu'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Tổng chi tiêu: ${totalExpenses.toStringAsFixed(2)} VNĐ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Chi tiêu theo tuần:', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              SizedBox(
                height: 400, // Tăng chiều cao của biểu đồ
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barGroups: weeklyExpenses.entries.map((entry) {
                      return BarChartGroupData(
                        x: int.parse(entry.key.replaceAll(RegExp(r'[^0-9]'), '')),
                        barRods: [
                          BarChartRodData(
                            toY: entry.value,
                            color: Colors.teal,
                            width: 20,
                            borderRadius: BorderRadius.circular(6),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: totalExpenses,
                              color: Colors.grey[300]!,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => Text(
                            value.toString(),
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          reservedSize: 40,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => Text(
                            value.toString(),
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          reservedSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
