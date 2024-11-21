import 'dart:math';

import 'package:monitoring_models/monitoring_models.dart';

extension MonitoringModelListExtension on List<MonitoringModel> {
  double get minY => map((e) => e.value.toDouble()).reduce(min);
  double get maxY => map((e) => e.value.toDouble()).reduce(max);
}
