import 'package:flutter/material.dart';
import 'package:monitoring_core/monitoring_core.dart';

import '../../../core/bloc/app_bloc.dart';

class UnitSelector extends StatelessWidget {
  const UnitSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitSelectorCubit, PowerUnit>(
      builder: (context, selectedUnit) {
        return SegmentedButton<PowerUnit>(
          selected: {selectedUnit},
          showSelectedIcon: false,
          segments: PowerUnit.values.map((unit) {
            return ButtonSegment<PowerUnit>(
              value: unit,
              label: Text(unit.symbol),
            );
          }).toList(),
          onSelectionChanged: (Set<PowerUnit> selection) {
            context.read<UnitSelectorCubit>().selectUnit(selection.first);
          },
        );
      },
    );
  }
}
