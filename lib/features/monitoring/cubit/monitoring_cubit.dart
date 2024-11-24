import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
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
    emit(state.toLoadingState().copyWith(selectedDate: date));

    final results =
        await _getMonitoringData(date, isForceRefresh: isForceRefresh);
    emit(state.copyWith(energyStates: results));

    if (date.isToday) {
      _setupPolling();
    } else {
      _cancelPolling();
    }
  }

  void resetData() {
    emit(state.copyWith(energyStates: {}));
    loadData(state.selectedDate, isForceRefresh: true);
  }

  Future<Map<EnergyType, MonitoringStateModel>> _getMonitoringData(
      DateTime date,
      {bool isForceRefresh = false}) async {
    final futures = EnergyType.values.map((type) async {
      try {
        final data = await _repository.getMonitoringData(
          type: type,
          date: date,
          resetCache: isForceRefresh,
        );
        return MapEntry(
          type,
          MonitoringStateModel(
            models: data,
            status: MonitoringStatus.success,
          ),
        );
      } catch (error) {
        return MapEntry(type, _handleError(type, error));
      }
    });

    final results = await Future.wait(futures);

    return Map.fromEntries(results);
  }

  MonitoringStateModel _handleError(EnergyType type, Object error) {
    final currentState = state.energyStates[type]!;
    return currentState.copyWith(
      status: MonitoringStatus.failure,
      error: error.toString(),
    );
  }

  void _setupPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_polDuration, (_) {
      if (state.selectedDate.isToday) {
        loadData(state.selectedDate, isForceRefresh: true);
      }
    });
  }

  void _cancelPolling() {
    _pollTimer?.cancel();
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
