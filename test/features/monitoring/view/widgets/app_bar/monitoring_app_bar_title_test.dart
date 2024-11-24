import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/app_bar/date_selector.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/app_bar/monitoring_app_bar_title.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/tab/unit_selector.dart';
import 'package:solar_monitoring/features/theme/model/theme_mode.dart';
import 'package:solar_monitoring/features/theme/view/theme_mode_toggle.dart';

import '../../../../theme/view/theme_mode_toggle_test.mocks.dart';
import 'date_selector_test.mocks.dart';
import 'monitoring_app_bar_test.mocks.dart';

@GenerateMocks([UnitSelectorCubit])
void main() {
  group('MonitoringAppBarTitle', () {
    late MockMonitoringCubit monitoringCubit;
    late MockMonitoringState monitoringState;
    late MockThemeCubit themeCubit;
    late MockUnitSelectorCubit unitSelectorCubit;
    late StreamController<MonitoringState> monitoringStream;
    late StreamController<AppThemeMode> themeStream;
    late StreamController<PowerUnit> unitStream;

    setUp(() {
      monitoringCubit = MockMonitoringCubit();
      monitoringState = MockMonitoringState();
      themeCubit = MockThemeCubit();
      unitSelectorCubit = MockUnitSelectorCubit();

      monitoringStream = StreamController<MonitoringState>.broadcast();
      themeStream = StreamController<AppThemeMode>.broadcast();
      unitStream = StreamController<PowerUnit>.broadcast();

      // Setup default behaviors
      when(monitoringCubit.state).thenReturn(monitoringState);
      when(monitoringCubit.stream).thenAnswer((_) => monitoringStream.stream);
      when(monitoringState.selectedDate).thenReturn(DateTime(2024, 1, 1));

      when(themeCubit.state).thenReturn(AppThemeMode.light);
      when(themeCubit.stream).thenAnswer((_) => themeStream.stream);

      when(unitSelectorCubit.state).thenReturn(PowerUnit.watts);
      when(unitSelectorCubit.stream).thenAnswer((_) => unitStream.stream);
    });

    tearDown(() async {
      await monitoringStream.close();
      await themeStream.close();
      await unitStream.close();
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<MonitoringCubit>.value(value: monitoringCubit),
            BlocProvider<ThemeCubit>.value(value: themeCubit),
            BlocProvider<UnitSelectorCubit>.value(value: unitSelectorCubit),
          ],
          child: const Scaffold(
            body: MonitoringAppBarTitle(),
          ),
        ),
      );
    }

    testWidgets('renders all components correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Verify Column exists
      final columnFinder = find.byType(Column);
      expect(columnFinder, findsOneWidget);

      // Verify Row with DateSelector and ThemeModeToggle
      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      final Row row = tester.widget(rowFinder);
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);

      // Verify DateSelector
      expect(find.byType(DateSelector), findsOneWidget);

      // Verify ThemeModeToggle
      expect(find.byType(ThemeModeToggle), findsOneWidget);

      // Verify UnitSelector with correct padding
      final paddingFinder = find.ancestor(
        of: find.byType(UnitSelector),
        matching: find.byType(Padding),
      );
      expect(paddingFinder, findsOneWidget);

      final Padding padding = tester.widget(paddingFinder);
      expect(
        padding.padding,
        const EdgeInsets.only(top: 8.0, bottom: 16.0), // Updated padding
      );
    });

    testWidgets('components receive correct state', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Verify date is displayed correctly
      expect(find.text('2024-01-01'), findsOneWidget);

      // Verify theme icon is correct
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);

      // Verify UnitSelector shows correct unit
      // Add specific unit selector verification based on your implementation
    });
  });
}
