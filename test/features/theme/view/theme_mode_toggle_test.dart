import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/features/theme/model/theme_mode.dart';
import 'package:solar_monitoring/features/theme/view/theme_mode_toggle.dart';

@GenerateMocks([ThemeCubit])
import 'theme_mode_toggle_test.mocks.dart';

void main() {
  group('ThemeModeToggle', () {
    late MockThemeCubit themeCubit;

    setUp(() {
      themeCubit = MockThemeCubit();
      // Setup default behavior
      when(themeCubit.state).thenReturn(AppThemeMode.light);
      when(themeCubit.stream)
          .thenAnswer((_) => Stream.value(AppThemeMode.light));
    });

    tearDown(() {
      // Clean up the mock
      reset(themeCubit);
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: BlocProvider<ThemeCubit>.value(
          value: themeCubit,
          child: const Scaffold(
            body: ThemeModeToggle(),
          ),
        ),
      );
    }

    testWidgets('renders IconButton', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('shows dark_mode icon when theme is light', (tester) async {
      when(themeCubit.state).thenReturn(AppThemeMode.light);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);
    });

    testWidgets('shows light_mode icon when theme is dark', (tester) async {
      when(themeCubit.state).thenReturn(AppThemeMode.dark);
      when(themeCubit.stream)
          .thenAnswer((_) => Stream.value(AppThemeMode.dark));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.light_mode), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode), findsNothing);
    });

    testWidgets('calls toggleTheme when pressed', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      verify(themeCubit.toggleTheme()).called(1);
    });
  });
}
