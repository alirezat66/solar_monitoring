class MonitoringModel {
  DateTime date;
  num value;

  MonitoringModel({required this.date, required this.value});

  factory MonitoringModel.fromJson(Map<String, dynamic> json) {
    return MonitoringModel(
      date: DateTime.parse(json['timestamp']),
      value: json['value'],
    );
  }
}
