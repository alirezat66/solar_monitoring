import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/state/monitoring_error_view.dart';

import '../app_bar/date_selector_test.mocks.dart';

void main() {
  group('MonitoringErrorView', () {
    late MockMonitoringCubit monitoringCubit;
    late MockMonitoringState monitoringState;
    const testError = 'Test error message';
    final testDate = DateTime(2024, 1, 1);

    setUp(() {
      monitoringCubit = MockMonitoringCubit();
      monitoringState = MockMonitoringState();

      when(monitoringCubit.state).thenReturn(monitoringState);
      when(monitoringState.selectedDate).thenReturn(testDate);

      // Stub the stream getter to avoid MissingStubError
      when(monitoringCubit.stream)
          .thenAnswer((_) => const Stream<MonitoringState>.empty());
    });

    Widget buildTestWidget({String error = testError}) {
      return MaterialApp(
        home: BlocProvider<MonitoringCubit>.value(
          value: monitoringCubit,
          child: Scaffold(
            body: MonitoringErrorView(error: error),
          ),
        ),
      );
    }

    testWidgets('renders all components correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Verify Column alignment
      final columnFinder = find.descendant(
        of: find.byType(MonitoringErrorView),
        matching: find.byType(Column),
      );
      expect(columnFinder, findsOneWidget);
      final Column column = tester.widget(columnFinder);
      expect(column.mainAxisAlignment, MainAxisAlignment.center);

      // Verify error icon
      final iconFinder = find.descendant(
        of: find.byType(MonitoringErrorView),
        matching: find.byType(Icon),
      );
      expect(iconFinder, findsOneWidget);
      final Icon icon = tester.widget(iconFinder);
      expect(icon.icon, Icons.error_outline);
      expect(icon.color, Colors.red);

      // Verify spacing using height predicate
      final spacerFinder = find.descendant(
        of: find.byType(MonitoringErrorView),
        matching: find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.height == 8,
        ),
      );
      expect(spacerFinder, findsOneWidget);

      // Verify error text
      expect(find.text(testError), findsOneWidget);

      // Verify retry button
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('displays provided error message', (tester) async {
      const customError = 'Custom error message';
      await tester.pumpWidget(buildTestWidget(error: customError));

      expect(find.text(customError), findsOneWidget);
    });

    testWidgets('retry button triggers loadData with correct date',
        (tester) async {
      when(monitoringCubit.loadData(testDate)).thenAnswer((_) async {});

      await tester.pumpWidget(buildTestWidget());

      await tester.tap(find.text('Retry'));
      await tester.pump();

      verify(monitoringCubit.loadData(testDate)).called(1);
    });

    testWidgets('handles long error messages', (tester) async {
      const longError = 'This is a very long error message that might wrap to '
          'multiple lines and we need to make sure it displays correctly';

      await tester.pumpWidget(buildTestWidget(error: longError));

      expect(find.text(longError), findsOneWidget);
    });

    testWidgets('maintains layout with empty error message', (tester) async {
      await tester.pumpWidget(buildTestWidget(error: ''));

      // Verify essential components
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('handles retry without throwing', (tester) async {
      when(monitoringCubit.loadData(testDate)).thenAnswer((_) async {});

      await tester.pumpWidget(buildTestWidget());

      await tester.tap(find.text('Retry'));
      await tester.pump();

      verify(monitoringCubit.loadData(testDate)).called(1);
    });
  });
}
