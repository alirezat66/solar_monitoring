import 'package:flutter_test/flutter_test.dart';
import 'package:solar_monitoring/features/theme/cubit/theme_cubit.dart';
import 'package:solar_monitoring/features/theme/model/theme_mode.dart';

void main() {
  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    tearDown(() {
      themeCubit.close();
    });

    test('initial state is AppThemeMode.light', () {
      expect(themeCubit.state, AppThemeMode.light);
    });

    test('toggleTheme changes state from light to dark', () {
      themeCubit.toggleTheme();
      expect(themeCubit.state, AppThemeMode.dark);
    });

    test('toggleTheme changes state from dark to light', () {
      themeCubit.toggleTheme(); // light to dark
      themeCubit.toggleTheme(); // dark to light
      expect(themeCubit.state, AppThemeMode.light);
    });
  });
}
