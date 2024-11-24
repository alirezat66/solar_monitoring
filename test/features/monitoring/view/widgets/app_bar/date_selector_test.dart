import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/app_bar/date_selector.dart';

import 'date_selector_test.mocks.dart';

@GenerateMocks([MonitoringCubit, MonitoringState])
void main() {
  group('DateSelector', () {
    late MockMonitoringCubit monitoringCubit;
    late MockMonitoringState monitoringState;
    late StreamController<MonitoringState> streamController;
    final testDate = DateTime(2024, 1, 1);

    setUp(() {
      monitoringCubit = MockMonitoringCubit();
      monitoringState = MockMonitoringState();
      streamController = StreamController<MonitoringState>.broadcast();

      // Setup default behaviors
      when(monitoringCubit.state).thenReturn(monitoringState);
      when(monitoringCubit.stream).thenAnswer((_) => streamController.stream);
      when(monitoringState.selectedDate).thenReturn(testDate);
    });

    tearDown(() async {
      await streamController.close();
      reset(monitoringCubit);
      reset(monitoringState);
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: BlocProvider<MonitoringCubit>.value(
          value: monitoringCubit,
          child: const Scaffold(
            body: DateSelector(),
          ),
        ),
      );
    }

    testWidgets('updates date when new date is selected', (tester) async {

      await tester.pumpWidget(buildTestWidget());
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      // Simulate date selection
      await tester.tap(find.text('1')); // Tap the day '1'
      await tester.tap(find.text('OK')); // Tap the 'OK' button
      await tester.pumpAndSettle();

      // Verify that the cubit's `loadData` was called with the new date
      verify(monitoringCubit.loadData(any)).called(1);
    });

    testWidgets('does not update date when selection is cancelled',
        (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      // Simulate cancelling the picker
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(monitoringCubit.loadData(any));
    });
  });
}
