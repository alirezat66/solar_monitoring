// test/core/di/injection_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_monitoring/core/di/service_locator.dart';
import 'package:solar_monitoring/core/network/network_client.dart';
import 'package:solar_monitoring/core/network/dio/dio_option.dart';

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
      expect(dioOptions.baseUrl, 'http://localhost:3000');
      expect(getIt.isRegistered<DioOptions>(), true);
    });

    test('should register NetworkClient as lazy singleton', () {
      // Arrange & Act
      final networkClient = getIt<NetworkClient>();

      // Assert
      expect(networkClient, isA<NetworkClient>());
      expect(getIt.isRegistered<NetworkClient>(), true);
    });
  });
}
