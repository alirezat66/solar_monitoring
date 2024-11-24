import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_repository/src/monitoring_repository.dart';

class MonitoringRepositoryImpl implements MonitoringRepository {
  final NetworkClient client;
  final String apiPath;
  MonitoringRepositoryImpl(
      {required this.client, this.apiPath = '/monitoring'});

  @override
  Future<List<MonitoringModel>> getMonitoringData({
    required DateTime date,
    required EnergyType type,
  }) async {
    final response = await client.get<List<dynamic>>(
      path: apiPath,
      queryParameters: {
        'date': date.formattedDate,
        'type': type.queryParam,
      },
    );

    return response.map((json) => MonitoringModel.fromJson(json)).toList();
  }
}
