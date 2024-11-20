abstract class NetworkClient {
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
  });

  void dispose();
}
