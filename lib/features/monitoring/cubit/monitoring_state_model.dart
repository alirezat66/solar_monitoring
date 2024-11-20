import 'package:equatable/equatable.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_cubit.dart';

class MonitoringStateModel extends Equatable {
  final List<MonitoringModel> models;
  final MonitoringStatus status;
  final String? error;

  const MonitoringStateModel({
    required this.models,
    required this.status,
    this.error,
  });
  factory MonitoringStateModel.initial() => const MonitoringStateModel(
        models: [],
        status: MonitoringStatus.initial,
      );
  MonitoringStateModel copyWith({
    List<MonitoringModel>? models,
    MonitoringStatus? status,
    String? error,
  }) {
    return MonitoringStateModel(
      models: models ?? this.models,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [models, status, error];
}
