import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:solar_monitoring/features/monitoring/cubit/unit_selector_cubit.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

void main() {
  group('UnitSelectorCubit', () {
    late UnitSelectorCubit unitSelectorCubit;

    setUp(() {
      unitSelectorCubit = UnitSelectorCubit();
    });

    tearDown(() {
      unitSelectorCubit.close();
    });

    test('initial state is PowerUnit.watts', () {
      expect(unitSelectorCubit.state, PowerUnit.watts);
    });

    blocTest<UnitSelectorCubit, PowerUnit>(
      'emits [PowerUnit.kilowatts] when selectUnit is called with PowerUnit.kilowatts',
      build: () => unitSelectorCubit,
      act: (cubit) => cubit.selectUnit(PowerUnit.kilowatts),
      expect: () => [PowerUnit.kilowatts],
    );

    blocTest<UnitSelectorCubit, PowerUnit>(
      'emits [PowerUnit.megawatts] when selectUnit is called with PowerUnit.megawatts',
      build: () => unitSelectorCubit,
      act: (cubit) => cubit.selectUnit(PowerUnit.watts),
      expect: () => [PowerUnit.watts],
    );
  });
}
