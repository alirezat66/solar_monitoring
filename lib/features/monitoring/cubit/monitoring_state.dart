part of 'monitoring_cubit.dart';

class MonitoringState extends Equatable {
  final Map<EnergyType, MonitoringStateModel> energyStates;
  final DateTime selectedDate;

  const MonitoringState({
    required this.energyStates,
    required this.selectedDate,
  });

  MonitoringState copyWith({
    Map<EnergyType, MonitoringStateModel>? energyStates,
    DateTime? selectedDate,
  }) {
    return MonitoringState(
      energyStates: energyStates ?? this.energyStates,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [energyStates, selectedDate];
}

enum MonitoringStatus { initial, loading, success, failure }
