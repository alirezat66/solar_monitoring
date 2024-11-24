import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_repository/src/monitoring_repository.dart';

class MonitoringRepositoryImpl implements MonitoringRepository {
  final NetworkClient client;
  final String apiPath;
  final Map<String, List<MonitoringModel>> _cache = {};
  MonitoringRepositoryImpl(
      {required this.client, this.apiPath = '/monitoring'});

  void clearCache() {
    _cache.clear();
  }

  @override
  Future<List<MonitoringModel>> getMonitoringData({
    required DateTime date,
    required EnergyType type,
    bool resetCache = false,
  }) async {
    final cacheKey = '${date.formattedDate}_${type.queryParam}';

    if (!date.isToday) {
      if (_cache.containsKey(cacheKey)) {
        return _cache[cacheKey]!;
      }
    }
    if (resetCache) {
      clearCache();
    }

    final response = await client.get<List<dynamic>>(
      path: apiPath,
      queryParameters: {
        'date': date.formattedDate,
        'type': type.queryParam,
      },
    );

    final data =
        response.map((json) => MonitoringModel.fromJson(json)).toList();
    if (!date.isToday) {
      _cache[cacheKey] = data;
    }
    return data;
  }
}
