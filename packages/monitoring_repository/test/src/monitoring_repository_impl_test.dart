// test/features/monitoring/repositories/monitoring_repository_test.dart
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_repository/monitoring_repository.dart';

import '../../../../test/fixtures/fixture_reader.dart';
import 'monitoring_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkClient])
void main() {
  late MonitoringRepositoryImpl sut;
  late MockNetworkClient mockClient;
  late List<dynamic> mockResponse;

  setUp(() async {
    // Load mock data once
    mockResponse = json.decode(
      fixture('monitoring_response.json'),
    );

    mockClient = MockNetworkClient();
    sut = MonitoringRepositoryImpl(client: mockClient);
  });

  group('MonitoringRepositoryImpl', () {
    test('should fetch monitoring data with correct parameters', () async {
      // Arrange
      final date = DateTime(2024, 11, 17);
      when(mockClient.get<List<dynamic>>(
        path: '/monitoring',
        queryParameters: {
          'date': '2024-11-17',
          'type': 'solar',
        },
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await sut.getMonitoringData(
        date: date,
        type: EnergyType.solar,
      );

      // Assert
      verify(mockClient.get<List<dynamic>>(
        path: '/monitoring',
        queryParameters: {
          'date': '2024-11-17',
          'type': 'solar',
        },
      )).called(1);

      // Verify against our fixture data
      expect(result.length, mockResponse.length);
      expect(
          result.first.date, DateTime.parse(mockResponse.first['timestamp']));
      expect(result.first.value, mockResponse.first['value']);
      expect(result.last.date, DateTime.parse(mockResponse.last['timestamp']));
      expect(result.last.value, mockResponse.last['value']);
    });

    test('should work with different energy types', () async {
      // Arrange
      final date = DateTime(2024, 11, 17);

      for (final type in EnergyType.values) {
        when(mockClient.get<List<dynamic>>(
          path: '/monitoring',
          queryParameters: {
            'date': '2024-11-17',
            'type': type.queryParam,
          },
        )).thenAnswer((_) async => mockResponse);

        // Act
        final result = await sut.getMonitoringData(
          date: date,
          type: type,
        );

        // Assert
        verify(mockClient.get<List<dynamic>>(
          path: '/monitoring',
          queryParameters: {
            'date': '2024-11-17',
            'type': type.queryParam,
          },
        )).called(1);

        // Verify data matches our fixture
        expect(result.length, mockResponse.length);
      }
    });

    test('should propagate errors from client', () async {
      // Arrange
      when(mockClient.get<List<dynamic>>(
        path: anyNamed('path'),
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => sut.getMonitoringData(
          date: DateTime(2024, 11, 17),
          type: EnergyType.solar,
        ),
        throwsException,
      );
    });
  });
}
