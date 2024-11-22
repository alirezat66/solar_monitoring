import 'package:monitoring_models/src/metrics/power_unit.dart';

class PowerValue {
  final double valueInWatts;
  final PowerUnit unit;

  const PowerValue({
    required this.valueInWatts,
    this.unit = PowerUnit.watts,
  });

  double get displayValue => valueInWatts * unit.conversion;

  String format() => '${displayValue.toStringAsFixed(2)} ${unit.symbol}';

  PowerValue convertTo(PowerUnit newUnit) =>
      PowerValue(valueInWatts: valueInWatts, unit: newUnit);
}
