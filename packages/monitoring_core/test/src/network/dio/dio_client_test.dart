import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_core/monitoring_core.dart';

import 'dio_client_test.mocks.dart';


@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late DioClient sut;

  setUp(() {
    mockDio = MockDio();
    sut = DioClient(
      options: const DioOptions(baseUrl: 'http://localhost:3000'),
    );
    sut.dio = mockDio; // Inject the mock
  });

  group('DioClient', () {
    const queryParams = {
      'date': '2024-11-17',
      'type': 'solar',
    };

    test('should get data successfully', () async {
      // Arrange
      final expectedData = [
        {'timestamp': '2024-10-17T00:00:00.000Z', 'value': 2758}
      ];

      when(mockDio.get<List<dynamic>>(
        any,
        queryParameters: queryParams,
      )).thenAnswer((_) async => Response(
            data: expectedData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final result = await sut.get<List<dynamic>>(
        path: '/monitoring',
        queryParameters: queryParams,
      );

      // Assert
      expect(result, expectedData);
      verify(mockDio.get<List<dynamic>>(
        '/monitoring',
        queryParameters: queryParams,
      )).called(1);
    });

    test('should throw exception on error', () async {
      // Arrange
      when(mockDio.get<List<dynamic>>(
        any,
        queryParameters: queryParams,
      )).thenThrow(DioException(
        type: DioExceptionType.connectionError,
        error: 'Connection failed',
        requestOptions: RequestOptions(path: ''),
      ));

      // Act & Assert
      expect(
        () => sut.get<List<dynamic>>(path: '/monitoring'),
        throwsA(isA<Exception>()),
      );
    });

    test('should pass query parameters', () async {
      // Arrange

      final expectedData = [
        {'timestamp': '2024-10-17T00:00:00.000Z', 'value': 2758}
      ];

      when(mockDio.get<List<dynamic>>(
        any,
        queryParameters: queryParams,
      )).thenAnswer((_) async => Response(
            data: expectedData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final result = await sut.get<List<dynamic>>(
        path: '/monitoring',
        queryParameters: queryParams,
      );

      // Assert
      expect(result, expectedData);
      verify(mockDio.get<List<dynamic>>(
        '/monitoring',
        queryParameters: queryParams,
      )).called(1);
    });
  });
}
