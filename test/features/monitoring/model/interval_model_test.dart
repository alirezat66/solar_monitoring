import 'package:flutter_test/flutter_test.dart';
import 'package:solar_monitoring/features/monitoring/model/interval_model.dart';

void main() {
  group('IntervalModel', () {
    test('creates proper intervals for standard range', () {
      final interval = IntervalModel.createNiceIntervals(
        lowerBound: 0,
        upperBound: 100,
      );

      expect(interval.lowerBound, lessThanOrEqualTo(0));
      expect(interval.upperBound, greaterThanOrEqualTo(100));
      expect(interval.interval, equals(50.0));
    });

    test('throws assertion error when bounds are invalid', () {
      expect(
        () => IntervalModel.createNiceIntervals(
          lowerBound: 100,
          upperBound: 50,
        ),
        throwsAssertionError,
      );

      expect(
        () => IntervalModel.createNiceIntervals(
          lowerBound: 0,
          upperBound: 0,
        ),
        throwsAssertionError,
      );
    });

    test('handles very small positive range', () {
      final interval = IntervalModel.createNiceIntervals(
        lowerBound: 1,
        upperBound: 1.1,
      );

      expect(interval.interval, lessThan(0.1));
      expect(interval.lowerBound, lessThanOrEqualTo(1));
      expect(interval.upperBound, greaterThanOrEqualTo(1.1));
    });

    test('handles large ranges', () {
      final interval = IntervalModel.createNiceIntervals(
        lowerBound: 1000,
        upperBound: 1000000,
      );

      expect(interval.interval % 1000, equals(0));
      expect(interval.lowerBound, lessThanOrEqualTo(1000));
      expect(interval.upperBound, greaterThanOrEqualTo(1000000));
    });

    test('applies correct padding', () {
      final interval = IntervalModel.createNiceIntervals(
        lowerBound: 100,
        upperBound: 200,
      );

      expect(
        interval.lowerBound,
        lessThanOrEqualTo(100 * 0.99),
      );
      expect(
        interval.upperBound,
        greaterThanOrEqualTo(200 * 1.01),
      );
    });
  });
}
