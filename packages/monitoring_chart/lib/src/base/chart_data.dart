import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:monitoring_chart/src/base/interval_model.dart';
import 'package:monitoring_chart/src/extensions/monitoring_model_extension.dart';
import 'package:monitoring_models/monitoring_models.dart';

class ChartData {
  final List<MonitoringModel> models;
  final double minY;
  final double maxY;
  final IntervalModel interval;

  ChartData._({
    required this.models,
    required this.minY,
    required this.maxY,
    required this.interval,
  });

  factory ChartData.fromMonitoringModelList(List<MonitoringModel> models) {
    if (models.isEmpty) {
      return ChartData._(
        models: [],
        minY: 0,
        maxY: 0,
        interval: IntervalModel(lowerBound: 0, upperBound: 0, interval: 0),
      );
    }
    final minY = models.isEmpty ? 0 : models.map((p) => p.value).reduce(min);
    final maxY = models.isEmpty ? 0 : models.map((p) => p.value).reduce(max);

    return ChartData._(
      models: models,
      minY: minY.toDouble(),
      maxY: maxY.toDouble(),
      interval:
          IntervalModel.createNiceIntervals(lowerBound: minY, upperBound: maxY),
    );
  }

  List<FlSpot> get spots => models.map((p) => p.spot).toList();
}
