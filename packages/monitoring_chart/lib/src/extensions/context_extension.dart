import 'package:flutter/material.dart';
import '../theme/chart_theme_extension.dart';

extension ContextExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Orientation get orientation => MediaQuery.of(this).orientation;

  ChartThemeExtension get chartTheme =>
      Theme.of(this).extension<ChartThemeExtension>()!;
}
