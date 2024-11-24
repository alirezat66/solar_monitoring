import 'package:flutter/material.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
class MonitoringErrorView extends StatelessWidget {
  final String error;

  const MonitoringErrorView({
    required this.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(height: 8),
          Text(error),
          TextButton(
            onPressed: () => context
                .read<MonitoringCubit>()
                .loadData(context.read<MonitoringCubit>().state.selectedDate),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
