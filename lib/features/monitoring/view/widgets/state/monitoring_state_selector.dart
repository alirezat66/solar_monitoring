import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_state_model.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/state/monitoring_state_view.dart';

import '../../../../../core/bloc/app_bloc.dart';

class MonitoringStateSelector extends StatelessWidget {
  final EnergyType type;

  const MonitoringStateSelector({
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MonitoringCubit, MonitoringState, MonitoringStateModel>(
      selector: (state) => MonitoringStateModel(
        models: state.energyStates[type]?.models ?? [],
        status: state.energyStates[type]?.status ?? MonitoringStatus.initial,
        error: state.energyStates[type]?.error,
      ),
      builder: (context, state) => MonitoringStateView(state: state),
    );
  }
}
