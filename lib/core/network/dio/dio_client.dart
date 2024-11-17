import 'package:solar_monitoring/core/network/dio/dio_option.dart';
import 'package:solar_monitoring/core/network/network_client.dart';
import 'package:dio/dio.dart';

class DioClient implements NetworkClient {
  final Dio _dio;

  DioClient({required DioOptions options})
      : _dio = Dio(options.toBaseOptions());

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
