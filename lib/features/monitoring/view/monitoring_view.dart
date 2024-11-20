import 'package:flutter/material.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';

class MonitoringView extends StatelessWidget {
  const MonitoringView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: EnergyType.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: BlocSelector<MonitoringCubit, MonitoringState, DateTime>(
            selector: (state) => state.selectedDate,
            builder: (context, date) => TextButton(
              onPressed: () => _showDatePicker(context),
              child: Text(date.toString()), // Use your date formatter
            ),
          ),
          bottom: TabBar(
            tabs: EnergyType.values.map((type) {
              final properties = type.properties;
              return Tab(
                text: properties.title,
                icon: Icon(properties.icon),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: EnergyType.values.map((type) {
            return BlocSelector<MonitoringCubit, MonitoringState, int>(
              selector: (state) => state.energyStates[type]?.models.length ?? 0,
              builder: (context, count) => Center(
                child: Text('Items count: $count'),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: context.read<MonitoringCubit>().state.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null && context.mounted) {
      context.read<MonitoringCubit>().loadData(date);
    }
  }
}
