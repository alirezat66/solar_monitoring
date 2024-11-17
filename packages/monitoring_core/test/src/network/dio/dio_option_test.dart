import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:monitoring_core/monitoring_core.dart';

void main() {
  group('DioOptions', () {
    test('should create instance with required baseUrl only', () {
      const options = DioOptions(baseUrl: 'https://api.example.com');

      expect(options.baseUrl, 'https://api.example.com');
      expect(options.connectTimeout, const Duration(seconds: 5));
      expect(options.receiveTimeout, const Duration(seconds: 3));
      expect(options.headers, {'Content-Type': 'application/json'});
    });

    test('should create instance with custom values', () {
      const options = DioOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout:  Duration(seconds: 10),
        receiveTimeout:  Duration(seconds: 6),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token',
        },
      );

      expect(options.baseUrl, 'https://api.example.com');
      expect(options.connectTimeout, const Duration(seconds: 10));
      expect(options.receiveTimeout, const Duration(seconds: 6));
      expect(options.headers, {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer token',
      });
    });

    test('toBaseOptions should correctly convert to Dio BaseOptions', () {
      const options = DioOptions(baseUrl: 'https://api.example.com');
      final baseOptions = options.toBaseOptions();

      expect(baseOptions, isA<BaseOptions>());
      expect(baseOptions.baseUrl, 'https://api.example.com');
      expect(baseOptions.connectTimeout, const Duration(seconds: 5));
      expect(baseOptions.receiveTimeout, const Duration(seconds: 3));
      expect(baseOptions.headers, {'Content-Type': 'application/json'});
    });

    test(
        'should not modify original headers when BaseOptions headers are modified',
        () {
      const options = DioOptions(baseUrl: 'https://api.example.com');
      final baseOptions = options.toBaseOptions();

      // Modify BaseOptions headers
      baseOptions.headers['Authorization'] = 'Bearer token';

      // Original DioOptions headers should remain unchanged
      expect(options.headers, {'Content-Type': 'application/json'});
    });
  });
}
