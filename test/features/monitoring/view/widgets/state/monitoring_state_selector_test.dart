import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/features/monitoring/cubit/monitoring_state_model.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/state/monitoring_state_selector.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/state/monitoring_state_view.dart';
import '../app_bar/date_selector_test.mocks.dart';

void main() {
  group('MonitoringStateSelector', () {
    late MockMonitoringCubit monitoringCubit;
    late MockMonitoringState monitoringState;
    const EnergyType testType = EnergyType.solar;

    setUp(() {
      monitoringCubit = MockMonitoringCubit();
      monitoringState = MockMonitoringState();

      // Stub the state and stream with consistent type
      when(monitoringCubit.state).thenReturn(monitoringState);
      when(monitoringCubit.stream).thenAnswer((_) => Stream.periodic(
          const Duration(milliseconds: 100), (_) => monitoringState).take(1));
      when(monitoringState.energyStates)
          .thenReturn(<EnergyType, MonitoringStateModel>{
        testType: const MonitoringStateModel(
            models: [], status: MonitoringStatus.initial, error: null),
      }); // Ensure energyStates is always a properly typed Map
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: BlocProvider<MonitoringCubit>.value(
          value: monitoringCubit,
          child: const Scaffold(
            body: MonitoringStateSelector(type: testType),
          ),
        ),
      );
    }

   

    testWidgets('displays initial state when no data is available',
        (tester) async {
      when(monitoringState.energyStates)
          .thenReturn(<EnergyType, MonitoringStateModel>{
        testType: const MonitoringStateModel(
            models: [], status: MonitoringStatus.initial, error: null),
      });

      await tester.pumpWidget(buildTestWidget());
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify MonitoringStateView receives an initial state
      expect(find.byType(MonitoringStateView), findsOneWidget);
      final monitoringStateView =
          tester.widget<MonitoringStateView>(find.byType(MonitoringStateView));
      expect(monitoringStateView.state.status, MonitoringStatus.initial);
      expect(monitoringStateView.state.models, isEmpty);
    });

    testWidgets('displays error state when an error occurs', (tester) async {
      const monitoringStateModel = MonitoringStateModel(
        models: [],
        status: MonitoringStatus.failure,
        error: 'An error occurred',
      );

      when(monitoringState.energyStates)
          .thenReturn(<EnergyType, MonitoringStateModel>{
        testType: monitoringStateModel,
      });

      await tester.pumpWidget(buildTestWidget());
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify MonitoringStateView receives the error state
      expect(find.byType(MonitoringStateView), findsOneWidget);
      final monitoringStateView =
          tester.widget<MonitoringStateView>(find.byType(MonitoringStateView));
      expect(monitoringStateView.state.status, MonitoringStatus.failure);
      expect(monitoringStateView.state.error, 'An error occurred');
    });
  });
}
