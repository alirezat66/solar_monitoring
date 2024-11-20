import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/features/monitoring/model/interval_model.dart';

extension MonitoringModelListExtension on List<MonitoringModel> {
  double get minY => map((e) => e.value.toDouble()).reduce(min);
  double get maxY => map((e) => e.value.toDouble()).reduce(max);

  IntervalModel get verticalInterval => IntervalModel.fromSpots(asMap()
      .entries
      .map(
          (entry) => FlSpot(entry.key.toDouble(), entry.value.value.toDouble()))
      .toList());

  List<FlSpot> normalizeToHours() {
    if (isEmpty) return [];

    // Find reference time (start of the day)
    final startOfDay = first.date.copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

    return map((model) {
      // Calculate seconds from start of day
      final secondsFromStart = model.date.difference(startOfDay).inSeconds;
      return FlSpot(
        secondsFromStart.toDouble(),
        model.value.toDouble(),
      );
    }).toList();
  }
}
