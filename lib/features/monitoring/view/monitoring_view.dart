import 'package:flutter/material.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_state_model.dart';
import 'package:solar_monitoring/features/monitoring/view/solar_bar_chart.dart';
import 'package:solar_monitoring/features/monitoring/view/unit_selector.dart';

class MonitoringView extends StatelessWidget {
  const MonitoringView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: EnergyType.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              BlocSelector<MonitoringCubit, MonitoringState, DateTime>(
                selector: (state) => state.selectedDate,
                builder: (context, date) => TextButton(
                  onPressed: () => _showDatePicker(context),
                  child:
                      Text(date.toQueryDateString()), // Use your date formatter
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: UnitSelector(),
              ),
            ],
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
          toolbarHeight: 100,
        ),
        body: TabBarView(
          children: EnergyType.values.map((type) {
            return BlocSelector<MonitoringCubit, MonitoringState,
                MonitoringStateModel>(
              selector: (state) => MonitoringStateModel(
                models: state.energyStates[type]?.models ?? [],
                status: state.energyStates[type]?.status ??
                    MonitoringStatus.initial,
                error: state.energyStates[type]?.error,
              ),
              builder: (context, chartState) {
                if (chartState.status == MonitoringStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (chartState.status == MonitoringStatus.failure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(height: 8),
                        Text(chartState.error ?? 'An error occurred'),
                        TextButton(
                          onPressed: () => context
                              .read<MonitoringCubit>()
                              .loadData(context
                                  .read<MonitoringCubit>()
                                  .state
                                  .selectedDate),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (chartState.models.isEmpty) {
                  return const Center(child: Text('No data available'));
                }

                return BlocBuilder<UnitSelectorCubit, PowerUnit>(
                  builder: (context, state) {
                    return MonitoringChart(
                      data: chartState.models,
                      unit: state,
                    );
                  },
                );
              },
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
