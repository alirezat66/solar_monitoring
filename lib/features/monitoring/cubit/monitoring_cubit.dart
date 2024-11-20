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
    state.toLoadingState();
    emit(state.toLoadingState().copyWith(selectedDate: date));

    try {
      final results = await _getMonitoringData(date);

      emit(state.toSuccessState(results));

      // Setup polling if current day
      if (_isCurrentDay(date)) {
        _setupPolling();
      } else {
        _cancelPolling();
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

  Future<List<List<MonitoringModel>>> _getMonitoringData(DateTime date) {
    return Future.wait(
      EnergyType.values.map((type) => _repository.getMonitoringData(
            type: type,
            date: date,
          )),
    );
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

  void _cancelPolling() {
    _pollTimer?.cancel();
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
