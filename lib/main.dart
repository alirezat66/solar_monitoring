import 'package:flutter/material.dart';
import 'package:solar_monitoring/core/bloc/bloc_observer.dart';
import 'package:solar_monitoring/core/di/service_locator.dart';
import 'package:solar_monitoring/core/theme/light_theme.dart';
import 'package:solar_monitoring/features/monitoring/view/monitoring_page.dart';

import 'core/bloc/app_bloc.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      home: const MonitoringPage(),
    );
  }
}
