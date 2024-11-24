import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_cubit.dart';

import 'monitoring_cubit_test.mocks.dart';

@GenerateMocks([MonitoringRepository])
void main() {
  group('MonitoringCubit', () {
    late MockMonitoringRepository repository;
    final testDate = DateTime(2024, 11, 19); // Past date

    setUp(() {
      repository = MockMonitoringRepository();
      when(repository.getMonitoringData(
        type: anyNamed('type'),
        date: anyNamed('date'),
      )).thenAnswer((_) async => []);
    });

    tearDown(() {
      reset(repository); // Reset mock calls
    });
    blocTest<MonitoringCubit, MonitoringState>(
      'initial state is correct',
      build: () => MonitoringCubit(repository: repository),
      verify: (cubit) {
        expect(cubit.state.energyStates.length, EnergyType.values.length);

        for (var type in EnergyType.values) {
          expect(
              cubit.state.energyStates[type]?.status, MonitoringStatus.initial);
          expect(cubit.state.energyStates[type]?.models, isEmpty);
        }
      },
    );

    blocTest<MonitoringCubit, MonitoringState>(
      'loads data successfully for past date',
      build: () => MonitoringCubit(repository: repository),
      act: (cubit) => cubit.loadData(testDate),
      expect: () => [
        // First emission: Loading state
        isA<MonitoringState>()
            .having(
              (state) => state.selectedDate,
              'selected date',
              testDate,
            )
            .having(
              (state) => state.energyStates[EnergyType.solar]?.status,
              'solar status loading',
              MonitoringStatus.loading,
            ),
        // Second emission: Success state
        isA<MonitoringState>()
            .having(
              (state) => state.selectedDate,
              'selected date',
              testDate,
            )
            .having(
              (state) => state.energyStates[EnergyType.solar]?.status,
              'solar status success',
              MonitoringStatus.success,
            ),
      ],
      verify: (cubit) {
        verify(repository.getMonitoringData(
          type: EnergyType.solar,
          date: testDate,
        )).called(1);
      },
    );

    blocTest<MonitoringCubit, MonitoringState>(
      'handles error when loading data',
      setUp: () {
        when(repository.getMonitoringData(
          type: anyNamed('type'),
          date: anyNamed('date'),
        )).thenThrow('Test error');
      },
      build: () => MonitoringCubit(repository: repository),
      act: (cubit) => cubit.loadData(testDate),
      expect: () => [
        // First emission: Loading state
        isA<MonitoringState>().having(
          (state) => state.energyStates.values.every(
            (stateModel) => stateModel.status == MonitoringStatus.loading,
          ),
          'all states loading',
          true,
        ),
        // Second emission: Error state
        isA<MonitoringState>().having(
          (state) => state.energyStates.values.every(
            (stateModel) =>
                stateModel.status == MonitoringStatus.failure &&
                stateModel.error == 'Test error',
          ),
          'all states error',
          true,
        ),
      ],
      verify: (cubit) {
        // Verify final state explicitly if needed
        for (var type in EnergyType.values) {
          expect(
            cubit.state.energyStates[type]?.status,
            MonitoringStatus.failure,
          );
          expect(
            cubit.state.energyStates[type]?.error,
            'Test error',
          );
        }
      },
    );

    blocTest<MonitoringCubit, MonitoringState>(
      'force refresh reloads data',
      build: () => MonitoringCubit(repository: repository),
      act: (cubit) async {
        await cubit.loadData(testDate);
        await cubit.loadData(testDate, isForceRefresh: true);
      },
      verify: (cubit) {
        // Verify the repository was called twice for each type
        verify(repository.getMonitoringData(
          type: anyNamed('type'),
          date: anyNamed('date'),
        )).called(EnergyType.values.length * 2); // Number of types * 2 calls
      },
      expect: () => [
        // First loadData loading state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) => model.status == MonitoringStatus.loading,
            )),
        // First loadData success state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) => model.status == MonitoringStatus.success,
            )),
        // Force refresh loading state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) => model.status == MonitoringStatus.loading,
            )),
        // Force refresh success state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) => model.status == MonitoringStatus.success,
            )),
      ],
    );

    blocTest<MonitoringCubit, MonitoringState>(
      'handles network error correctly',
      setUp: () {
        when(repository.getMonitoringData(
          type: anyNamed('type'),
          date: anyNamed('date'),
        )).thenThrow(Exception('Network error'));
      },
      build: () => MonitoringCubit(repository: repository),
      act: (cubit) => cubit.loadData(testDate),
      expect: () => [
        // Loading state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) => model.status == MonitoringStatus.loading,
            )),
        // Error state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) =>
                  model.status == MonitoringStatus.failure &&
                  model.error == 'Exception: Network error',
            )),
      ],
      verify: (cubit) {
        // Verify final state explicitly
        for (var type in EnergyType.values) {
          expect(
              cubit.state.energyStates[type]?.status, MonitoringStatus.failure);
          expect(cubit.state.energyStates[type]?.error,
              'Exception: Network error');
        }
      },
    );

    blocTest<MonitoringCubit, MonitoringState>(
      'handles mixed success and error states when loading data',
      setUp: () {
        // Success for solar and house
        when(repository.getMonitoringData(
          type: EnergyType.solar,
          date: anyNamed('date'),
        )).thenAnswer((_) async => [
              MonitoringModel(date: testDate, value: 100),
            ]);

        when(repository.getMonitoringData(
          type: EnergyType.house,
          date: anyNamed('date'),
        )).thenAnswer((_) async => [
              MonitoringModel(date: testDate, value: 200),
            ]);

        // Error for battery
        when(repository.getMonitoringData(
          type: EnergyType.battery,
          date: anyNamed('date'),
        )).thenThrow(Exception('Battery data error'));
      },
      build: () => MonitoringCubit(repository: repository),
      act: (cubit) => cubit.loadData(testDate),
      expect: () => [
        // Initial loading state
        isA<MonitoringState>().having(
          (state) => state.energyStates.values
              .every((model) => model.status == MonitoringStatus.loading),
          'all states loading',
          true,
        ),
        // Mixed state - success for solar and house, error for battery
        isA<MonitoringState>()
            .having(
              (state) => state.energyStates[EnergyType.solar]?.status,
              'solar success status',
              MonitoringStatus.success,
            )
            .having(
              (state) => state.energyStates[EnergyType.house]?.status,
              'house success status',
              MonitoringStatus.success,
            )
            .having(
              (state) => state.energyStates[EnergyType.battery]?.status,
              'battery error status',
              MonitoringStatus.failure,
            )
            .having(
              (state) => state.energyStates[EnergyType.battery]?.error,
              'battery error message',
              'Exception: Battery data error',
            ),
      ],
      verify: (cubit) {
        verify(repository.getMonitoringData(
          type: EnergyType.battery,
          date: testDate,
        )).called(1);
      },
    );

    blocTest<MonitoringCubit, MonitoringState>(
      'recovers from error state on retry',
      setUp: () {
        // First call throws error
        when(repository.getMonitoringData(
          type: anyNamed('type'),
          date: anyNamed('date'),
        )).thenThrow('Test error');
      },
      build: () => MonitoringCubit(repository: repository),
      act: (cubit) async {
        await cubit.loadData(testDate);

        // Second call returns success
        when(repository.getMonitoringData(
          type: anyNamed('type'),
          date: anyNamed('date'),
        )).thenAnswer(
            (_) async => [MonitoringModel(date: testDate, value: 50)]);

        await cubit.loadData(testDate);
      },
      expect: () => [
        // First loadData - Loading state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) => model.status == MonitoringStatus.loading,
            )),
        // First loadData - Error state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) =>
                  model.status == MonitoringStatus.failure &&
                  model.error == 'Test error',
            )),
        // Second loadData - Loading state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) => model.status == MonitoringStatus.loading,
            )),
        // Second loadData - Success state
        predicate<MonitoringState>((state) => state.energyStates.values.every(
              (model) =>
                  model.status == MonitoringStatus.success &&
                  model.error == null &&
                  model.models.length == 1 &&
                  model.models.first.value == 50,
            )),
      ],
      verify: (cubit) {
        for (var type in EnergyType.values) {
          expect(
              cubit.state.energyStates[type]?.status, MonitoringStatus.success);
          expect(cubit.state.energyStates[type]?.error, isNull);
        }
      },
    );

    blocTest<MonitoringCubit, MonitoringState>(
      'maintains state consistency across different date loads',
      setUp: () {
        var callCount = 0;
        when(repository.getMonitoringData(
          type: anyNamed('type'),
          date: anyNamed('date'),
        )).thenAnswer((_) async {
          callCount++;
          return [
            MonitoringModel(
              date: testDate,
              value: callCount * 100,
            )
          ];
        });
      },
      build: () => MonitoringCubit(repository: repository),
      act: (cubit) async {
        await cubit.loadData(testDate);
        await cubit.loadData(DateTime.now());
      },
      expect: () => [
        // First load - Loading state
        isA<MonitoringState>()
            .having(
              (state) => state.selectedDate,
              'selected date',
              testDate,
            )
            .having(
              (state) => state.energyStates.values.every((model) =>
                  model.status == MonitoringStatus.loading &&
                  model.models.isEmpty),
              'loading states',
              true,
            ),
        // First load - Success state
        isA<MonitoringState>()
            .having(
              (state) => state.selectedDate,
              'selected date',
              testDate,
            )
            .having(
              (state) => state.energyStates.values.every((model) =>
                      model.status == MonitoringStatus.success &&
                      model.models.length == 1 &&
                      model.models.first.value <=
                          300 // Since callCount * 100 for first 3 calls
                  ),
              'success states with correct values',
              true,
            ),
        // Second load - Loading state
        isA<MonitoringState>()
            .having(
              (state) => state.selectedDate.day,
              'current day',
              DateTime.now().day,
            )
            .having(
              (state) => state.energyStates.values
                  .every((model) => model.status == MonitoringStatus.loading),
              'loading states',
              true,
            ),
        // Second load - Success state
        isA<MonitoringState>()
            .having(
              (state) => state.selectedDate.day,
              'current day',
              DateTime.now().day,
            )
            .having(
              (state) => state.energyStates.values.every((model) =>
                      model.status == MonitoringStatus.success &&
                      model.models.length == 1 &&
                      model.models.first.value <=
                          600 // Since callCount * 100 for next 3 calls
                  ),
              'success states with correct values',
              true,
            ),
      ],
      verify: (cubit) {
        verify(repository.getMonitoringData(
          type: anyNamed('type'),
          date: anyNamed('date'),
        )).called(EnergyType.values.length * 2);
      },
    );
    group('polling behavior', () {
      late DateTime currentDay;
      late DateTime previousDay;

      setUp(() {
        currentDay = DateTime.now();
        previousDay = DateTime(2024, 1, 1);
      });

      blocTest<MonitoringCubit, MonitoringState>(
        'sets up polling for current day',
        setUp: () {
          when(repository.getMonitoringData(
            type: anyNamed('type'),
            date: anyNamed('date'),
          )).thenAnswer((_) async {
            return [];
          });
        },
        build: () => MonitoringCubit(repository: repository),
        act: (cubit) => cubit.loadData(currentDay),
        verify: (_) {
          verify(repository.getMonitoringData(
            type: anyNamed('type'),
            date: anyNamed('date'),
          )).called(EnergyType.values.length); // Initial calls only
        },
        expect: () => [
          predicate<MonitoringState>((state) => state.energyStates.values.every(
                (model) => model.status == MonitoringStatus.loading,
              )),
          predicate<MonitoringState>((state) => state.energyStates.values.every(
                (model) => model.status == MonitoringStatus.success,
              )),
        ],
      );

      blocTest<MonitoringCubit, MonitoringState>(
        'polling calls repository method periodically',
        setUp: () {
          when(repository.getMonitoringData(
            type: anyNamed('type'),
            date: anyNamed('date'),
          )).thenAnswer((_) async => []);
        },
        build: () => MonitoringCubit(
            repository: repository, polDuration: const Duration(seconds: 5)),
        act: (cubit) async {
          await cubit.loadData(DateTime.now());
          await Future.delayed(const Duration(seconds: 5));
        },
        wait: const Duration(seconds: 6), // Wait for polling to occur
        verify: (_) {
          verify(repository.getMonitoringData(
            type: anyNamed('type'),
            date: anyNamed('date'),
          )).called(
              greaterThan(EnergyType.values.length)); // More than initial calls
        },
        expect: () => anything,
      );
      blocTest<MonitoringCubit, MonitoringState>(
        'does not set up polling for past date',
        build: () => MonitoringCubit(repository: repository),
        act: (cubit) => cubit.loadData(previousDay),
        wait: const Duration(seconds: 1), // Short wait to ensure no polling
        expect: () => [
          // First load - Loading state
          isA<MonitoringState>().having(
            (state) => state.energyStates.values.every(
              (model) => model.status == MonitoringStatus.loading,
            ),
            'loading state',
            true,
          ),
          // First load - Success state
          isA<MonitoringState>().having(
            (state) => state.energyStates.values.every(
              (model) => model.status == MonitoringStatus.success,
            ),
            'success state',
            true,
          ),
        ],
        verify: (_) {
          verify(repository.getMonitoringData(
            type: anyNamed('type'),
            date: previousDay,
          )).called(EnergyType.values.length);
        },
      );
    });
  });
}
