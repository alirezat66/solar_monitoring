part of 'monitoring_cubit.dart';

class MonitoringState extends Equatable {
  final Map<EnergyType, MonitoringStateModel> energyStates;
  final DateTime selectedDate;

  const MonitoringState({
    required this.energyStates,
    required this.selectedDate,
  });
  factory MonitoringState.initial() => MonitoringState(
        energyStates: Map.fromIterables(
          EnergyType.values,
          EnergyType.values.map(
            (_) => const MonitoringStateModel(
              models: [],
              status: MonitoringStatus.initial,
            ),
          ),
        ),
        selectedDate: DateTime.now(),
      );
  MonitoringState copyWith({
    Map<EnergyType, MonitoringStateModel>? energyStates,
    DateTime? selectedDate,
  }) {
    return MonitoringState(
      energyStates: energyStates ?? this.energyStates,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  MonitoringState toLoadingState() => copyWith(
        energyStates: Map.fromEntries(
          energyStates.entries.map(
            (entry) => MapEntry(
              entry.key,
              entry.value.copyWith(status: MonitoringStatus.loading),
            ),
          ),
        ),
      );

  MonitoringState toSuccessState(List<List<MonitoringModel>> results) =>
      copyWith(
        energyStates: Map.fromIterables(
          EnergyType.values,
          results.map(
            (data) => MonitoringStateModel(
              models: data,
              status: MonitoringStatus.success,
            ),
          ),
        ),
      );
  @override
  List<Object?> get props => [energyStates, selectedDate];
}

enum MonitoringStatus { initial, loading, success, failure }
