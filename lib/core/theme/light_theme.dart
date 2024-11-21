import 'package:flutter/material.dart';
import 'package:solar_monitoring/core/theme/chart_theme.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  extensions: [ChartTheme.light],
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  extensions: [ChartTheme.dark],
);
