import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  extensions: [ChartTheme.light],
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  extensions: [ChartTheme.dark],
);
