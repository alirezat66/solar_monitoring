
import 'package:monitoring_core/monitoring_core.dart';

abstract class MonitoringRepository {
  Future<List<MonitoringModel>> getMonitoringData({
    required DateTime date,
    required EnergyType type,
  });
}
