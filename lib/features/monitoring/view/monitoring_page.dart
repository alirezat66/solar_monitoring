import 'package:flutter/widgets.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/core/di/service_locator.dart';

import 'monitoring_view.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MonitoringCubit>()..loadData(DateTime.now()),
      child: const MonitoringView(),
    );
  }
}