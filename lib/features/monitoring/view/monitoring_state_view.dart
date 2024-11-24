import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_state_model.dart';
import 'package:solar_monitoring/features/monitoring/view/monitoring_chart.dart';
import 'package:solar_monitoring/features/monitoring/view/monitoring_error_view.dart';

class MonitoringStateView extends StatelessWidget {
  final MonitoringStateModel state;

  const MonitoringStateView({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return switch (state.status) {
      MonitoringStatus.loading => const Center(
          child: CircularProgressIndicator(),
        ),
      MonitoringStatus.failure => MonitoringErrorView(
          error: state.error ?? 'An error occurred',
        ),
      _ when state.models.isEmpty => const Center(
          child: Text('No data available'),
        ),
      _ => BlocBuilder<UnitSelectorCubit, PowerUnit>(
          builder: (context, unit) => MonitoringChart(
            data: state.models,
            unit: unit,
          ),
        ),
    };
  }
}
