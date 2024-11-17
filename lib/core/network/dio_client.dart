import 'package:solar_monitoring/core/network/network_client.dart';
import 'package:dio/dio.dart';

class DioClient implements NetworkClient {
  final Dio _dio;

  DioClient({required String baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
          headers: {'Content-Type': 'application/json'},
        ));

  @override
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      return response.data as T;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  void dispose() {
    _dio.close(force: true);
  }
}
