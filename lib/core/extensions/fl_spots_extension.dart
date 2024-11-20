import 'package:fl_chart/fl_chart.dart';
import 'package:solar_monitoring/features/monitoring/model/interval_model.dart';

extension FlSpotsExtension on List<FlSpot> {
  IntervalModel get verticalInterval => IntervalModel.fromSpots(this);

  double get maxY =>
      fold<double>(0, (max, spot) => spot.y > max ? spot.y : max);
  double get minY =>
      fold<double>(double.infinity, (min, spot) => spot.y < min ? spot.y : min);
}
