import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

import '../../../core/bloc/app_bloc.dart';

class MonitoringChart extends StatelessWidget {
  final List<MonitoringModel> data;
  final PowerUnit unit;
  const MonitoringChart({
    super.key,
    required this.data,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MonitoringCubit>().resetData();
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio:
                      MediaQuery.orientationOf(context) == Orientation.landscape
                          ? context.chartTheme.chartAspectRatioLandscape
                          : context.chartTheme.chartAspectRatioPortrait,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: EnergyLineChart(
                      data: data,
                      unit: unit,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
