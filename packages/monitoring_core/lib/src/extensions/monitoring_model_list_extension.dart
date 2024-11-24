import 'dart:math';

import 'package:monitoring_core/monitoring_core.dart';

extension MonitoringModelListExtension on List<MonitoringModel> {
  double get minY => map((e) => e.value.toDouble()).reduce(min);
  double get maxY => map((e) => e.value.toDouble()).reduce(max);
}
