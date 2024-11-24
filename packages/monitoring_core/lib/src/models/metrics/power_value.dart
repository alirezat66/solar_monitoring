import 'power_unit.dart';

class PowerValue {
  final double valueInWatts;
  final PowerUnit unit;

  const PowerValue({
    required this.valueInWatts,
    this.unit = PowerUnit.watts,
  });

  double get  displayValue => valueInWatts * unit.conversion;

  String format() {
    final String stringValue = displayValue.toStringAsFixed(2);
    final List<String> parts = stringValue.split('.');

    // If decimal part is "00", return just the integer part
    if (parts[1] == '00') {
      return parts[0];
    }

    // If decimal part ends with 0, remove it
    if (parts[1].endsWith('0')) {
      return '${parts[0]}.${parts[1].substring(0, 1)}';
    }
    return stringValue;
  }

  PowerValue convertTo(PowerUnit newUnit) =>
      PowerValue(valueInWatts: valueInWatts, unit: newUnit);
}
