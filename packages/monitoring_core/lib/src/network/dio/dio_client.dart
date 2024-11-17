import 'package:monitoring_core/monitoring_core.dart';
import 'package:dio/dio.dart';
import 'package:monitoring_core/src/network/dio/dio_option.dart';

class DioClient implements NetworkClient {
  Dio _dio;

  DioClient({required DioOptions options})
      : _dio = Dio(options.toBaseOptions());

  // Setter for testing purposes
  set dio(Dio dio) {
    _dio = dio;
  }

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
