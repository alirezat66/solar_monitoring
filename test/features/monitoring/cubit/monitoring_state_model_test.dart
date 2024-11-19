import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_cubit.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_state_model.dart';

void main() {
  group('MonitoringStateModel', () {
    // Test data
    final testDate = DateTime(2024, 1, 1);
    final models = [
      MonitoringModel(
        date: testDate,
        value: 100,
      ),
      MonitoringModel(
        date: testDate.add(const Duration(hours: 1)),
        value: 200,
      ),
    ];

    test('constructor creates instance with required parameters', () {
      final state = MonitoringStateModel(
        models: models,
        status: MonitoringStatus.success,
      );

      expect(state.models, models);
      expect(state.status, MonitoringStatus.success);
      expect(state.error, null);
    });

    test('constructor creates instance with all parameters', () {
      final state = MonitoringStateModel(
        models: models,
        status: MonitoringStatus.failure,
        error: 'Test error',
      );

      expect(state.models, models);
      expect(state.status, MonitoringStatus.failure);
      expect(state.error, 'Test error');
    });

    group('copyWith', () {
      test('returns same object when no parameters are provided', () {
        final state = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
        );

        final copiedState = state.copyWith();

        expect(copiedState.models, state.models);
        expect(copiedState.status, state.status);
        expect(copiedState.error, state.error);
        expect(copiedState, state);
      });

      test('returns object with updated models when only models is provided',
          () {
        final state = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
        );

        final newModels = [
          MonitoringModel(
            date: testDate,
            value: 300,
          ),
        ];

        final copiedState = state.copyWith(models: newModels);

        expect(copiedState.models, newModels);
        expect(copiedState.status, state.status);
        expect(copiedState.error, state.error);
        expect(copiedState, isNot(state));
      });

      test('returns object with updated status when only status is provided',
          () {
        final state = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
        );

        final copiedState = state.copyWith(status: MonitoringStatus.loading);

        expect(copiedState.models, state.models);
        expect(copiedState.status, MonitoringStatus.loading);
        expect(copiedState.error, state.error);
        expect(copiedState, isNot(state));
      });

      test('returns object with updated error when only error is provided', () {
        final state = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
        );

        final copiedState = state.copyWith(error: 'New error');

        expect(copiedState.models, state.models);
        expect(copiedState.status, state.status);
        expect(copiedState.error, 'New error');
        expect(copiedState, isNot(state));
      });

      test(
          'returns object with all updated fields when all parameters provided',
          () {
        final state = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
        );

        final newModels = [
          MonitoringModel(
            date: testDate,
            value: 300,
          ),
        ];

        final copiedState = state.copyWith(
          models: newModels,
          status: MonitoringStatus.failure,
          error: 'New error',
        );

        expect(copiedState.models, newModels);
        expect(copiedState.status, MonitoringStatus.failure);
        expect(copiedState.error, 'New error');
        expect(copiedState, isNot(state));
      });
    });

    group('equality', () {
      test('equal when all properties match', () {
        final state1 = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
          error: 'Test error',
        );

        final state2 = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
          error: 'Test error',
        );

        expect(state1, state2);
      });

      test('not equal when models differ', () {
        final state1 = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
        );

        final state2 = MonitoringStateModel(
          models: [
            MonitoringModel(
              date: testDate,
              value: 300,
            ),
          ],
          status: MonitoringStatus.success,
        );

        expect(state1, isNot(state2));
      });

      test('not equal when status differs', () {
        final state1 = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
        );

        final state2 = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.loading,
        );

        expect(state1, isNot(state2));
      });

      test('not equal when error differs', () {
        final state1 = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.failure,
          error: 'Error 1',
        );

        final state2 = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.failure,
          error: 'Error 2',
        );

        expect(state1, isNot(state2));
      });

      test('props contains all fields', () {
        final state = MonitoringStateModel(
          models: models,
          status: MonitoringStatus.success,
          error: 'Test error',
        );

        expect(
          state.props,
          [models, MonitoringStatus.success, 'Test error'],
        );
      });
    });
  });
}
