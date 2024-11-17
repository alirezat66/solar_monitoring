// test/core/di/injection_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitoring/core/constants/api_constants.dart';
import 'package:solar_monitoring/core/di/service_locator.dart';

void main() {
  setUp(() async {
    await GetIt.I.reset();
    await initializeDependencies();
  });

  group('Dependencies Registration', () {
    test('should register DioOptions as singleton', () {
      // Arrange & Act
      final dioOptions = getIt<DioOptions>();

      // Assert
      expect(dioOptions, isA<DioOptions>());
      expect(dioOptions.baseUrl, apiBaseUrl);
      expect(getIt.isRegistered<DioOptions>(), true);
    });

    test('should register NetworkClient as lazy singleton', () {
      // Arrange & Act
      final networkClient = getIt<NetworkClient>();

      // Assert
      expect(networkClient, isA<NetworkClient>());
      expect(networkClient, isA<DioClient>());
      expect(getIt.isRegistered<NetworkClient>(), true);
    });

    test('should register Monitoring Repository as lazy singleton', () {
      // Arrange & Act
      final monitoringRepository = getIt<MonitoringRepository>();

      // Assert
      expect(monitoringRepository, isA<MonitoringRepository>());
      expect(monitoringRepository, isA<MonitoringRepositoryImpl>());
      expect(getIt.isRegistered<MonitoringRepository>(), true);
    });
  });
}
