import 'package:get_it/get_it.dart';
import 'package:solar_monitoring/core/constants/api_constants.dart';
import 'package:solar_monitoring/core/network/dio/dio_client.dart';
import 'package:solar_monitoring/core/network/dio/dio_option.dart';
import 'package:solar_monitoring/core/network/network_client.dart';

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
