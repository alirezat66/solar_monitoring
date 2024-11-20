import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_models/monitoring_models.dart';

class MonitoringChart extends StatefulWidget {
  final List<MonitoringModel> data;
  final Color chartColor;
  final Color tooltipColor;

  const MonitoringChart({
    super.key,
    required this.data,
    this.chartColor = Colors.blue,
    this.tooltipColor = Colors.pink,
  });

  @override
  State<MonitoringChart> createState() => _MonitoringChartState();
}

class _MonitoringChartState extends State<MonitoringChart> {
  List<int> selectedSpots = [];

  List<FlSpot> get spots => widget.data.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value.value.toDouble());
      }).toList();

  String _formatTime(int index) {
    if (index >= 0 && index < widget.data.length) {
      final date = widget.data[index].date;
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: LineChart(
          LineChartData(
            // Line styling
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                showingIndicators: selectedSpots,
                isCurved: true,
                barWidth: 3,
                color: widget.chartColor,
                belowBarData: BarAreaData(
                  show: true,
                  color: widget.chartColor.withOpacity(0.2),
                ),
                dotData: const FlDotData(show: false),
              ),
            ],

            // Touch interactions
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipRoundedRadius: 8,
                getTooltipItems: (spots) {
                  return spots.map((spot) {
                    return LineTooltipItem(
                      '${spot.y.toInt()} W\n${_formatTime(spot.x.toInt())}',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
              getTouchedSpotIndicator: (barData, indices) {
                return indices.map((index) {
                  return TouchedSpotIndicatorData(
                    FlLine(color: widget.tooltipColor),
                    FlDotData(
                      show: true,
                      getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                        radius: 6,
                        color: Colors.white,
                        strokeWidth: 2,
                        strokeColor: widget.tooltipColor,
                      ),
                    ),
                  );
                }).toList();
              },
            ),

            // Axis styling
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 2000,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: widget.data.isNotEmpty
                      ? (widget.data.length ~/ 6).toDouble()
                      : 1.0, // Show ~6 labels
                  getTitlesWidget: (value, meta) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _formatTime(value.toInt()),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Grid and border
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 2000,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(show: false),

            // Value range
            minY: 0,
            maxY: 10000,
          ),
        ),
      ),
    );
  }
}
