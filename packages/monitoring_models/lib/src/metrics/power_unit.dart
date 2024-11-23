import 'package:monitoring_models/src/metrics/metric_unit.dart';

enum PowerUnit implements MetricUnit {
  watts(symbol: 'Watts', conversion: 1),
  kilowatts(symbol: 'kWatts', conversion: 0.001);

  @override
  final String symbol;
  @override
  final double conversion;

  const PowerUnit({
    required this.symbol,
    required this.conversion,
  });
}
