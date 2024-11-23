import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:monitoring_chart/src/base/interval_model.dart';
import 'package:monitoring_chart/src/extensions/monitoring_model_extension.dart';
import 'package:monitoring_models/monitoring_models.dart';

class ChartData {
  final List<MonitoringModel> models;
  final double minY;
  final double maxY;
  final double minX;
  final double maxX;
  final IntervalModel interval;
  final PowerUnit displayUnit;

  ChartData._({
    required this.models,
    required this.minY,
    required this.maxY,
    required this.minX,
    required this.maxX,
    required this.interval,
    this.displayUnit = PowerUnit.watts,
  });

  factory ChartData.fromMonitoringModelList(
    List<MonitoringModel> models, {
    PowerUnit displayUnit = PowerUnit.watts,
    double minX = 0,
    double maxX = 86400,
  }) {
    final values = models
        .map((m) => PowerValue(valueInWatts: m.value.toDouble())
            .convertTo(displayUnit)
            .displayValue)
        .toList();
    if (minX != 0 && maxX != 86400) {
      models = models
          .where((m) =>
              m.secondsFromMidnight >= minX && m.secondsFromMidnight <= maxX)
          .toList();
    }
    final minY = values.isEmpty ? 0 : values.reduce(min);
    final maxY = values.isEmpty ? 0 : values.reduce(max);

    return ChartData._(
      models: models,
      minY: minY.toDouble(),
      maxY: maxY.toDouble(),
      minX: minX,
      maxX: maxX,
      interval: IntervalModel.createNiceIntervals(
        lowerBound: minY,
        upperBound: maxY,
      ),
      displayUnit: displayUnit,
    );
  }

  List<FlSpot> get spots => models.map((model) {
        final value = PowerValue(valueInWatts: model.value.toDouble())
            .convertTo(displayUnit)
            .displayValue;
        return FlSpot(
          model.secondsFromMidnight.toDouble(),
          value,
        );
      }).toList();
}
