import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_cubit.dart';

class MonitoringView extends StatelessWidget {
  const MonitoringView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MonitoringCubit, MonitoringState>(
        builder: (context, state) {
          return Center(
            child: Text(
                'Hello World! ${state.energyStates.entries.first.value.status}'),
          );
        },
      ),
    );
  }
}
