import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EnergyLineChart', () {
    late List<MonitoringModel> mockData;

    setUp(() {
      // Create mock data for testing
      mockData = [
        MonitoringModel(
            date: DateTime.fromMillisecondsSinceEpoch(0), value: 10),
        MonitoringModel(
            date: DateTime.fromMillisecondsSinceEpoch(3600 * 1000), value: 20),
        MonitoringModel(
            date: DateTime.fromMillisecondsSinceEpoch(7200 * 1000), value: 30),
      ];
    });

    testWidgets('renders correctly with default configuration',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [ChartTheme.light],
        ),
        home: Scaffold(
          body: EnergyLineChart(
            data: mockData,
          ),
        ),
      ));

      expect(find.byType(LineChart), findsOneWidget);
    });

    testWidgets('renders correctly with custom configuration',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [ChartTheme.light],
        ),
        home: Scaffold(
          body: EnergyLineChart(
            data: mockData,
            minX: 0,
            maxX: 7200,
            unit: PowerUnit.kilowatts,
          ),
        ),
      ));

      expect(find.byType(LineChart), findsOneWidget);
    });

    testWidgets('displays correct data points', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [ChartTheme.light],
        ),
        home: Scaffold(
          body: EnergyLineChart(
            data: mockData,
            minX: 0,
            maxX: 7200,
          ),
        ),
      ));

      final lineChart = tester.widget<LineChart>(find.byType(LineChart));
      final lineChartData = lineChart.data;

      expect(lineChartData.lineBarsData.first.spots.length, mockData.length);
      expect(lineChartData.lineBarsData.first.spots[0].x,
          mockData[0].date.millisecondsSinceEpoch / 1000 + 3600);
      expect(lineChartData.lineBarsData.first.spots[0].y, mockData[0].value);
      expect(lineChartData.lineBarsData.first.spots[1].x,
          mockData[1].date.millisecondsSinceEpoch / 1000 + 3600);
      expect(lineChartData.lineBarsData.first.spots[1].y, mockData[1].value);
      expect(lineChartData.lineBarsData.first.spots[2].x,
          mockData[2].date.millisecondsSinceEpoch / 1000 + 3600);
      expect(lineChartData.lineBarsData.first.spots[2].y, mockData[2].value);
    });
  });
}
