import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/core/extensions/fl_spots_extension.dart';
import 'package:solar_monitoring/core/extensions/monitoring_model_extension.dart';
import 'package:solar_monitoring/features/monitoring/view/chart_style.dart';

class MonitoringChart extends StatefulWidget {
  final List<MonitoringModel> data;

  const MonitoringChart({
    super.key,
    required this.data,
  });

  @override
  State<MonitoringChart> createState() => _MonitoringChartState();
}

class _MonitoringChartState extends State<MonitoringChart> {
  List<int> selectedSpots = [];

  List<FlSpot> get spots => widget.data.normalizeToHours();


  @override
  Widget build(BuildContext context) {
    final verticalInterval = widget.data.verticalInterval;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: ChartStyle.chartAspectRatio,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: LineChart(
              LineChartData(
                  minY: verticalInterval.min,
                  maxY: verticalInterval.max,
                  lineBarsData: spots.getLineBarData(context),
                  gridData: spots.flGridData,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text((value / 3600).toString());
                          },
                          interval: 4 * 3600),
                    ),
                    topTitles: const AxisTitles(
                      drawBelowEverything: false,
                    ),
                    rightTitles: const AxisTitles(
                      drawBelowEverything: false,
                    ),
                  ),
                  lineTouchData: const LineTouchData(
                    enabled: false,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
