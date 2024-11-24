# Monitoring Chart

The `monitoring_chart` package provides an implementation of customizable energy monitoring charts using the `fl_chart` library. It allows developers to visualize energy monitoring data effectively through line charts with configurable appearance and behavior. The package integrates closely with `monitoring_core` to use its models, extensions, and utilities for displaying energy data.

## Features Overview

- **Chart Data Conversion**: Transforms energy monitoring data into chart-friendly formats.
- **Configurable Line Charts**: Customizable line chart configurations including titles, touch interactions, grid lines, and themes.
- **Theming Support**: Custom light and dark themes for charts to suit different UI requirements.

## ChartData

The `ChartData` class is responsible for processing a list of `MonitoringModel` objects into data that can be visualized on a chart.

### Features

- `ChartData.fromMonitoringModelList()`: Factory method to create a `ChartData` instance from a list of `MonitoringModel` objects.
- `spots`: Converts the energy data into `FlSpot` points, ready to be used by `fl_chart`.

### Example Usage

```dart
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

void main() {
  final models = [
    MonitoringModel(date: DateTime.now(), value: 120),
    MonitoringModel(date: DateTime.now().add(Duration(hours: 1)), value: 200),
  ];
  final chartData = ChartData.fromMonitoringModelList(models);
  print(chartData.spots); // Outputs a list of FlSpot points
}
```

## Chart Configuration

### ChartConfig

The `ChartConfig` class provides configuration for titles, labels, and touch interactions for a chart. It helps customize the visual representation of the chart data.

#### Features

- `buildTitlesData()`: Configures the labels for the chart, including axis titles and tick intervals.
- `buildTouchData()`: Configures how the chart responds to touch interactions, including tooltips.

### Example Usage

```dart
import 'package:flutter/material.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

void main(BuildContext context) {
  final config = ChartConfig(
    context,
    leftInterval: IntervalModel.createNiceIntervals(lowerBound: 0, upperBound: 100),
  );
  final titlesData = config.buildTitlesData();
  print(titlesData); // Outputs FlTitlesData configuration
}
```

### ChartGridConfig

The `ChartGridConfig` class provides customization for the grid lines displayed in the chart, making it possible to control visibility, color, and thickness of the lines.

#### Features

- `buildGridData()`: Generates `FlGridData` for controlling the horizontal and vertical grid lines in the chart.

### ChartLineConfig

The `ChartLineConfig` class provides configuration for the line that represents energy data in the chart.

#### Features

- `buildLineData()`: Generates the data for the line, including color, width, and whether the line should be curved.

### Example Usage

```dart
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:flutter/material.dart';

void main() {
  final spots = [FlSpot(0, 10), FlSpot(1, 20)];
  final theme = ChartTheme.light;
  final lineConfig = ChartLineConfig(spots: spots, theme: theme);
  print(lineConfig.buildLineData()); // Outputs LineChartBarData configuration
}
```

## Theming

### ChartTheme

The `ChartTheme` class provides both light and dark themes for energy monitoring charts. It allows easy switching between different styles for the charts based on the user's preference.

#### Features

- **Light Theme**: A theme suitable for light mode applications.
- **Dark Theme**: A theme suitable for dark mode applications.

### Example Usage

```dart
import 'package:monitoring_chart/monitoring_chart.dart';

void main() {
  final theme = ChartTheme.dark;
  print(theme.lineColor); // Outputs color used for line in dark theme
}
```

## Extensions

### ContextExt

The `ContextExt` extension adds helpful methods to the `BuildContext` to easily access theme properties related to charts.

### MonitoringModelExtension

The `MonitoringModelExtension` provides methods for converting a `MonitoringModel` instance into `FlSpot` points and calculating the seconds from midnight.

## Widget: EnergyLineChart

The `EnergyLineChart` widget is the main widget provided by this package, enabling developers to quickly integrate energy line charts into their applications.

### Features

- Displays energy monitoring data as a line chart.
- Configurable using `ChartConfig`, `ChartLineConfig`, and `ChartGridConfig`.

### Example Usage

```dart
import 'package:flutter/material.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

class EnergyChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final models = [
      MonitoringModel(date: DateTime.now(), value: 120),
      MonitoringModel(date: DateTime.now().add(Duration(hours: 1)), value: 200),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Energy Monitoring Chart')),
      body: Center(
        child: EnergyLineChart(
          data: models,
          unit: PowerUnit.kilowatts,
        ),
      ),
    );
  }
}
```

## Widget: MonitoringChart

The `MonitoringChart` widget is another widget provided by this package, enabling developers to integrate monitoring charts into their applications.

### Features

- Displays monitoring data as a chart.
- Configurable using `ChartConfig`, `ChartLineConfig`, and `ChartGridConfig`.

### Example Usage

```dart
import 'package:flutter/material.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

class MonitoringChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final models = [
      MonitoringModel(date: DateTime.now(), value: 120),
      MonitoringModel(date: DateTime.now().add(Duration(hours: 1)), value: 200),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Monitoring Chart')),
      body: Center(
        child: MonitoringChart(
          data: models,
          unit: PowerUnit.kilowatts,
        ),
      ),
    );
  }
}
```

## Dependencies

This package relies on the following:

- **monitoring_core**: Provides the data models, extensions, and utilities needed for creating charts.
- **fl_chart**: Used to create the visual line chart representation of the energy monitoring data.
- **Flutter Material Widgets**: Utilized for creating and styling the chart's UI components.

## Conclusion

The `monitoring_chart` package allows for seamless integration of energy data visualization into Flutter applications. By leveraging `fl_chart`, various theming options, and utility extensions from `monitoring_core`, developers can easily create rich, interactive charts for monitoring energy data.

Feel free to explore and contribute to the package if you'd like to add more features or improve existing ones.

