import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_models/monitoring_models.dart';

class MonitoringChart extends StatelessWidget {
  final List<MonitoringModel> data;

  const MonitoringChart({
    super.key,
    required this.data,
  });

  List<FlSpot> _normalizeData() {
    if (data.isEmpty) return [];

    // Find min/max values
    double minY = data[0].value.toDouble();
    double maxY = data[0].value.toDouble();
    for (var item in data) {
      if (item.value < minY) minY = item.value.toDouble();
      if (item.value > maxY) maxY = item.value.toDouble();
    }

    // Normalize data points
    return data.asMap().entries.map((entry) {
      final normalizedY =
          entry.value.value.toDouble(); // Using actual value for now
      return FlSpot(entry.key.toDouble(), normalizedY);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: _normalizeData(),
            barWidth: 2,
            dotData: const FlDotData(show: false),
            isCurved: true,
            curveSmoothness: 0.2,
          ),
        ],
        minY: 0, // Set minimum value
        maxY: 10000, // Set maximum expected value
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (data.length ~/ 6).toDouble(), // Show ~6 time labels
              getTitlesWidget: (value, meta) => SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  _getTimeFromIndex(value.toInt()),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 2000,
              reservedSize: 40,
            ),
          ),
        ),
        gridData: const FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2000,
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  String _getTimeFromIndex(int index) {
    if (index >= 0 && index < data.length) {
      final date = data[index].date;
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
    return '';
  }
}
