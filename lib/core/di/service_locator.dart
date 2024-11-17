import 'package:get_it/get_it.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:solar_monitoring/core/constants/api_constants.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Network
  getIt.registerSingleton<DioOptions>(
    const DioOptions(baseUrl: apiBaseUrl),
  );

  getIt.registerLazySingleton<NetworkClient>(
    () => DioClient(options: getIt<DioOptions>()),
  );
}
