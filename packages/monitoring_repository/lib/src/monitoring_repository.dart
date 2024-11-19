import 'package:monitoring_models/monitoring_models.dart';

abstract class MonitoringRepository {
  Future<List<MonitoringModel>> getMonitoringData({
    required DateTime date,
    required EnergyType type,
  });
}
