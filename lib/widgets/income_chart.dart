import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class RevenueChart extends StatelessWidget {
  const RevenueChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue Breakdown',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$4,650,278',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Text(
            '39% Increased vs last month',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true))
                  // leftTitles: SideTitles(showTitles: true),
                  // bottomTitles: SideTitles(showTitles: true),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 800),
                      FlSpot(1, 1200),
                      FlSpot(2, 1000),
                      FlSpot(3, 1500),
                      FlSpot(4, 1400),
                      FlSpot(5, 1600),
                      FlSpot(6, 1800),
                    ],
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 500),
                      FlSpot(1, 700),
                      FlSpot(2, 800),
                      FlSpot(3, 900),
                      FlSpot(4, 1000),
                      FlSpot(5, 1100),
                      FlSpot(6, 1270),
                    ],
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

