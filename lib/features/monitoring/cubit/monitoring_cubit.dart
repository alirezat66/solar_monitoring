import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_state_model.dart';

part 'monitoring_state.dart';

class MonitoringCubit extends Cubit<MonitoringState> {
  final MonitoringRepository _repository;
  final Duration _polDuration;
  Timer? _pollTimer;

  MonitoringCubit({
    required MonitoringRepository repository,
    Duration? polDuration,
  })  : _repository = repository,
        _polDuration = polDuration ?? const Duration(seconds: 30),
        super(MonitoringState.initial());

  Future<void> loadData(DateTime date, {bool isForceRefresh = false}) async {
    // Update loading state for all types
    final loadingStates =
        Map<EnergyType, MonitoringStateModel>.from(state.energyStates);
    for (var type in EnergyType.values) {
      loadingStates[type] = state.energyStates[type]!.copyWith(
        status: MonitoringStatus.loading,
      );
    }

    emit(state.copyWith(
      energyStates: loadingStates,
      selectedDate: date,
    ));

    try {
      // Load all data in parallel
      final results = await Future.wait(
        EnergyType.values.map((type) => _repository.getMonitoringData(
              type: type,
              date: date,
            )),
      );

      // Update states with results
      final newStates =
          Map<EnergyType, MonitoringStateModel>.from(state.energyStates);
      for (var i = 0; i < EnergyType.values.length; i++) {
        final type = EnergyType.values[i];
        newStates[type] = MonitoringStateModel(
          models: results[i],
          status: MonitoringStatus.success,
        );
      }

      emit(state.copyWith(energyStates: newStates));

      // Setup polling if current day
      if (_isCurrentDay(date)) {
        _setupPolling();
      } else {
        _pollTimer?.cancel();
      }
    } catch (e) {
      final errorStates =
          Map<EnergyType, MonitoringStateModel>.from(state.energyStates);
      for (var type in EnergyType.values) {
        errorStates[type] = state.energyStates[type]!.copyWith(
          status: MonitoringStatus.failure,
          error: e.toString(),
        );
      }

      emit(state.copyWith(energyStates: errorStates));
    }
  }

  void updateData(EnergyType type, List<MonitoringModel> data) {
    final newStates =
        Map<EnergyType, MonitoringStateModel>.from(state.energyStates);
    newStates[type] = MonitoringStateModel(
      models: data,
      status: MonitoringStatus.success,
    );

    emit(state.copyWith(energyStates: newStates));
  }

  bool _isCurrentDay(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  void _setupPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_polDuration, (_) {
      if (_isCurrentDay(state.selectedDate)) {
        loadData(state.selectedDate, isForceRefresh: true);
      }
    });
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
