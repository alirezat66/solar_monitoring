abstract class MetricUnit {
  final String symbol;
  final double conversion;

  const MetricUnit({
    required this.symbol,
    required this.conversion,
  });
}
