import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/src/base/interval_model.dart';
import 'package:monitoring_chart/src/base/chart_data.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  group('IntervalModel', () {
    test('creates instance with provided values', () {
      final model = IntervalModel(
        interval: 10,
        lowerBound: 0,
        upperBound: 100,
      );

      expect(model.interval, equals(10));
      expect(model.lowerBound, equals(0));
      expect(model.upperBound, equals(100));
    });

    group('createNiceIntervals', () {
      test('creates nice intervals for typical range', () {
        final model = IntervalModel.createNiceIntervals(
          lowerBound: 0,
          upperBound: 100,
        );

        expect(model.interval, greaterThan(0));
        expect(model.lowerBound, lessThanOrEqualTo(0));
        expect(model.upperBound, greaterThanOrEqualTo(100));
      });

      test('handles small ranges correctly', () {
        final model = IntervalModel.createNiceIntervals(
          lowerBound: 1,
          upperBound: 5,
        );

        expect(model.interval, greaterThan(0));
        expect(model.lowerBound, lessThanOrEqualTo(1));
        expect(model.upperBound, greaterThanOrEqualTo(5));
      });

      test('handles large ranges correctly', () {
        final model = IntervalModel.createNiceIntervals(
          lowerBound: 0,
          upperBound: 1000000,
        );

        expect(model.interval, greaterThan(0));
        expect(model.lowerBound, lessThanOrEqualTo(0));
        expect(model.upperBound, greaterThanOrEqualTo(1000000));
      });

      test('handles negative ranges correctly', () {
        final model = IntervalModel.createNiceIntervals(
          lowerBound: -100,
          upperBound: 100,
        );

        expect(model.interval, greaterThan(0));
        expect(model.lowerBound, lessThanOrEqualTo(-100));
        expect(model.upperBound, greaterThanOrEqualTo(100));
      });

      test('handles close bounds correctly', () {
        final model = IntervalModel.createNiceIntervals(
          lowerBound: 99,
          upperBound: 100,
        );

        expect(model.interval, greaterThan(0));
        expect(model.lowerBound, lessThanOrEqualTo(99));
        expect(model.upperBound, greaterThanOrEqualTo(100));
      });

      test('creates expected intervals for specific ranges', () {
        // Test cases with expected results
        final testCases = [
          (
            lowerBound: 0.0,
            upperBound: 10,
            expectedInterval: 2.0,
          ),
          (
            lowerBound: 0.0,
            upperBound: 100,
            expectedInterval: 20.0,
          ),
          (
            lowerBound: 0.0,
            upperBound: 5.0,
            expectedInterval: 1.0,
          ),
        ];

        for (final testCase in testCases) {
          final model = IntervalModel.createNiceIntervals(
            lowerBound: testCase.lowerBound,
            upperBound: testCase.upperBound,
          );

          expect(
            model.interval,
            equals(testCase.expectedInterval),
            reason:
                'Failed for range ${testCase.lowerBound} to ${testCase.upperBound}',
          );
        }
      });

      group('assertions', () {
        test('throws when both bounds are zero', () {
          expect(
            () => IntervalModel.createNiceIntervals(
              lowerBound: 0,
              upperBound: 0,
            ),
            throwsA(isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Both bounds cannot be zero',
            )),
          );
        });

        test('throws when lower bound is greater than upper bound', () {
          expect(
            () => IntervalModel.createNiceIntervals(
              lowerBound: 100,
              upperBound: 0,
            ),
            throwsA(isA<AssertionError>().having(
              (e) => e.message,
              'message',
              'Lower bound must be smaller than upper bound',
            )),
          );
        });
      });

      group('edge cases', () {
        test('handles very small numbers correctly', () {
          final model = IntervalModel.createNiceIntervals(
            lowerBound: 0.0001,
            upperBound: 0.0005,
          );

          expect(model.interval, greaterThan(0));
          expect(model.lowerBound, lessThanOrEqualTo(0.0001));
          expect(model.upperBound, greaterThanOrEqualTo(0.0005));
        });

        test('handles very large numbers correctly', () {
          final model = IntervalModel.createNiceIntervals(
            lowerBound: 1e6,
            upperBound: 1e7,
          );

          expect(model.interval, greaterThan(0));
          expect(model.lowerBound, lessThanOrEqualTo(1e6));
          expect(model.upperBound, greaterThanOrEqualTo(1e7));
        });

        test('handles zero lower bound correctly', () {
          final model = IntervalModel.createNiceIntervals(
            lowerBound: 0,
            upperBound: 10,
          );

          expect(model.interval, greaterThan(0));
          expect(model.lowerBound, equals(0));
          expect(model.upperBound, greaterThanOrEqualTo(10));
        });

        test('handles equal non-zero bounds correctly', () {
          final model = IntervalModel.createNiceIntervals(
            lowerBound: 100,
            upperBound: 100,
          );

          expect(model.interval, equals(0.2));
          expect(model.lowerBound, lessThanOrEqualTo(100));
          expect(model.upperBound, greaterThanOrEqualTo(100));
        });
      });
    });
  });

  group('ChartData', () {
    test('creates instance from monitoring model list', () {
      final models = [
        MonitoringModel(date: DateTime(2023, 1, 1, 0, 0, 0), value: 10),
        MonitoringModel(date: DateTime(2023, 1, 1, 1, 0, 0), value: 20),
        MonitoringModel(date: DateTime(2023, 1, 1, 2, 0, 0), value: 30),
      ];

      final chartData = ChartData.fromMonitoringModelList(models);

      expect(chartData.models, equals(models));
      expect(chartData.minY, equals(10));
      expect(chartData.maxY, equals(30));
      expect(chartData.minX, equals(0));
      expect(chartData.maxX, equals(86400));
      expect(chartData.interval, isA<IntervalModel>());
      expect(chartData.displayUnit, equals(PowerUnit.watts));
    });

    test('filters models based on minX and maxX', () {
      final models = [
        MonitoringModel(date: DateTime(2023, 1, 1, 0, 0, 0), value: 10),
        MonitoringModel(date: DateTime(2023, 1, 1, 1, 0, 0), value: 20),
        MonitoringModel(date: DateTime(2023, 1, 1, 2, 0, 0), value: 30),
      ];

      final chartData = ChartData.fromMonitoringModelList(
        models,
        minX: 1000,
        maxX: 5000,
      );

      expect(chartData.models.length, equals(1));
      expect(chartData.models.first.date.hour, equals(1));
    });


    test('generates correct spots', () {
      final models = [
        MonitoringModel(date: DateTime(2023, 1, 1, 0, 0, 0), value: 10),
        MonitoringModel(date: DateTime(2023, 1, 1, 1, 0, 0), value: 20),
        MonitoringModel(date: DateTime(2023, 1, 1, 2, 0, 0), value: 30),
      ];

      final chartData = ChartData.fromMonitoringModelList(models);

      final spots = chartData.spots;

      expect(spots.length, equals(3));
      expect(spots[0], equals(const FlSpot(0, 10)));
      expect(spots[1], equals(const FlSpot(3600, 20)));
      expect(spots[2], equals(const FlSpot(7200, 30)));
    });
  });
}
