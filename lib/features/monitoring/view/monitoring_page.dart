import 'package:flutter/widgets.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/core/di/service_locator.dart';
import 'package:solar_monitoring/features/monitoring/view/monitoring_view.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<MonitoringCubit>()..loadData(DateTime.now()),
        ),
        BlocProvider(
          create: (context) => getIt<UnitSelectorCubit>(),
        ),
      ],
      child: const MonitoringView(),
    );
  }
}
