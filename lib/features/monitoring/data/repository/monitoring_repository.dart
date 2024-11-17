import 'package:solar_monitoring/features/monitoring/data/model/energy_type.dart';
import 'package:solar_monitoring/features/monitoring/data/model/monitoring_model.dart';

abstract class MonitoringRepository {
  Future<List<MonitoringModel>> getMonitoringData({
    required DateTime date,
    required EnergyType type,
  });
}
