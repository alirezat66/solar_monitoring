import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/core/constants/api_constants.dart';
import 'package:solar_monitoring/features/monitoring/data/repository/monitoring_repository.dart';

class MonitoringRepositoryImpl implements MonitoringRepository {
  final NetworkClient client;

  MonitoringRepositoryImpl({required this.client});

  @override
  Future<List<MonitoringModel>> getMonitoringData({
    required DateTime date,
    required EnergyType type,
  }) async {
    final response = await client.get<List<dynamic>>(
      path: apiMonitoringPath,
      queryParameters: {
        'date': date.toQueryDateString(),
        'type': type.queryParam,
      },
    );

    return response.map((json) => MonitoringModel.fromJson(json)).toList();
  }
}
