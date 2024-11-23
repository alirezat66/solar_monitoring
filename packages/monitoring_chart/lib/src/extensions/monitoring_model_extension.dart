import 'package:fl_chart/fl_chart.dart';
import 'package:monitoring_models/monitoring_models.dart';

extension MonitoringModelExtension on MonitoringModel {
  int get secondsFromMidnight => (date.hour * 3600 + date.minute * 60 + date.second);

  FlSpot get spot => FlSpot(secondsFromMidnight.toDouble(), value.toDouble());
}
