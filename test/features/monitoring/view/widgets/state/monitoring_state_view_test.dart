import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_cubit.dart';
import 'package:solar_monitoring/features/monitoring/cubit/unit_selector_cubit.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/state/monitoring_error_view.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/state/monitoring_state_view.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_state_model.dart';
import 'package:solar_monitoring/features/monitoring/view/monitoring_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_bar/monitoring_app_bar_title_test.mocks.dart';

void main() {
  late MockUnitSelectorCubit mockUnitSelectorCubit;

  setUp(() {
    mockUnitSelectorCubit = MockUnitSelectorCubit();
    when(mockUnitSelectorCubit.state).thenReturn(PowerUnit.kilowatts);
  });

  testWidgets('displays CircularProgressIndicator when status is loading',
      (WidgetTester tester) async {
    const state =
        MonitoringStateModel(status: MonitoringStatus.loading, models: []);

    await tester.pumpWidget(const MaterialApp(
      home: MonitoringStateView(state: state),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays MonitoringErrorView when status is failure',
      (WidgetTester tester) async {
    const state = MonitoringStateModel(
        status: MonitoringStatus.failure, error: 'Test error', models: []);

    await tester.pumpWidget(const MaterialApp(
      home: MonitoringStateView(state: state),
    ));

    expect(find.byType(MonitoringErrorView), findsOneWidget);
    expect(find.text('Test error'), findsOneWidget);
  });

  testWidgets('displays "No data available" when models list is empty',
      (WidgetTester tester) async {
    const state =
        MonitoringStateModel(status: MonitoringStatus.success, models: []);

    await tester.pumpWidget(const MaterialApp(
      home: MonitoringStateView(state: state),
    ));

    expect(find.text('No data available'), findsOneWidget);
  });

  testWidgets(
      'displays MonitoringChart when status is success and models are available',
      (WidgetTester tester) async {
    final state = MonitoringStateModel(
      status: MonitoringStatus.success,
      models: [
        MonitoringModel(date: DateTime.now(), value: 100),
        MonitoringModel(date: DateTime.now(), value: 105)
      ],
    );

    when(mockUnitSelectorCubit.state).thenReturn(PowerUnit.watts);
    when(mockUnitSelectorCubit.stream)
        .thenAnswer((_) => Stream.value(PowerUnit.watts));

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [
            ChartTheme.light,
          ],
        ),
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(400, 800),
          ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<UnitSelectorCubit>.value(
                value: mockUnitSelectorCubit,
              ),
            ],
            child: Scaffold(
              body: MonitoringStateView(state: state),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(MonitoringChart), findsOneWidget);
  });

  // Additional test to verify chart updates with unit changes
  testWidgets('chart updates when unit changes', (WidgetTester tester) async {
    final streamController = StreamController<PowerUnit>.broadcast();

    when(mockUnitSelectorCubit.state).thenReturn(PowerUnit.watts);
    when(mockUnitSelectorCubit.stream)
        .thenAnswer((_) => streamController.stream);

    final state = MonitoringStateModel(
      status: MonitoringStatus.success,
      models: [
        MonitoringModel(date: DateTime.now(), value: 100),
        MonitoringModel(date: DateTime.now(), value: 105)
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [
            ChartTheme.light,
          ],
        ),
        home: BlocProvider<UnitSelectorCubit>.value(
          value: mockUnitSelectorCubit,
          child: Scaffold(
            body: MonitoringStateView(state: state),
          ),
        ),
      ),
    );

    // Initial render
    await tester.pump();
    expect(find.byType(MonitoringChart), findsOneWidget);

    // Change unit
    when(mockUnitSelectorCubit.state).thenReturn(PowerUnit.kilowatts);
    streamController.add(PowerUnit.kilowatts);

    await tester.pump();
    expect(find.byType(MonitoringChart), findsOneWidget);

    // Clean up
    streamController.close();
  });
}
