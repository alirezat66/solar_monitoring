import 'package:dio/dio.dart';

class DioOptions {
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Map<String, String> headers;

  /// Creates an instance of [DioOptions] with the specified parameters.
  ///
  /// [baseUrl] - The base URL for all requests.
  /// [connectTimeout] - The connection timeout duration (defaults to 5 seconds).
  /// [receiveTimeout] - The receive timeout duration (defaults to 3 seconds).
  /// [headers] - The headers for all requests (defaults to JSON content type).
  const DioOptions({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 5),
    this.receiveTimeout = const Duration(seconds: 3),
    this.headers = const {'Content-Type': 'application/json'},
  });

  BaseOptions toBaseOptions() => BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: headers,
      );
}
