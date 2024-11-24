import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MonitoringCubit, MonitoringState, DateTime>(
      selector: (state) => state.selectedDate,
      builder: (context, date) => TextButton(
        onPressed: () => _showDatePicker(context),
        child: Text(date.formattedDate),
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
