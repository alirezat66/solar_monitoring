# Monitoring Core

This package, `monitoring_core`, provides various utilities and helper classes, including extensions for date and number manipulation, network client implementation using `Dio`, and models for handling energy data and metrics. This package aims to simplify development by providing common utilities for handling dates, numbers, HTTP requests, and energy monitoring.

## Features Overview

- **Date & Number Extensions**: Useful methods for working with `DateTime` and `num` to make code more concise and readable.
- **Network Client with Dio**: A wrapper around the `Dio` package that makes HTTP requests easier and more structured.
- **Energy Models**: Data models for representing energy types, monitoring metrics, and power values, making it easy to handle energy-related data.

## Extensions

### DateExtension

The `DateExtension` is an extension on `DateTime` that provides utility properties for formatting dates and checking whether a given date is today.

#### Features

- `formattedDate`: Formats a `DateTime` instance into a `YYYY-MM-DD` string.
- `isToday`: Checks if the current `DateTime` instance represents today's date.

#### Example Usage

```dart
import 'extensions/date_extension.dart';

void main() {
  DateTime date = DateTime.now();
  print(date.formattedDate);  // Output: "2024-11-23" (current date)
  print(date.isToday);        // Output: true
}
```

### NumExtension

The `NumExtension` provides utility methods for working with numerical values, such as formatting durations or numbers to a string with specific precision.

#### Features

- `toHourMinuteString()`: Converts a numerical value representing seconds into a `HH:mm` formatted string.
- `formatValue([int decimals = 2])`: Converts a number to a string representation with a given number of decimal places, removing unnecessary trailing zeros.

#### Example Usage

```dart
import 'extensions/num_extension.dart';

void main() {
  num duration = 3665;
  print(duration.toHourMinuteString());  // Output: "01:01"

  num value = 123.4500;
  print(value.formatValue());            // Output: "123.45"
  print(value.formatValue(1));           // Output: "123.5"
}
```

## Network Client

The `monitoring_core` package also provides a `DioClient` implementation that makes network communication straightforward and consistent, utilizing the popular `Dio` package for making HTTP requests.

### DioClient

The `DioClient` class implements the `NetworkClient` interface and provides an easy-to-use abstraction for making network requests using the popular `Dio` package.

#### Features

- `get<T>()`: Makes a GET request to the specified path with optional query parameters and returns the response data as a specified type.
- `dispose()`: Disposes of the Dio instance to clean up resources.

#### Example Usage

```dart
import 'network/dio_client.dart';
import 'network/dio_options.dart';

void main() async {
  final options = DioOptions(baseUrl: 'https://api.example.com');
  final client = DioClient(options: options);

  try {
    final data = await client.get<String>(path: '/endpoint');
    print(data);
  } catch (e) {
    print(e);
  } finally {
    client.dispose();
  }
```

### DioOptions

The `DioOptions` class provides a convenient way to manage configuration for the Dio client, such as base URL, connection timeouts, and custom headers.

#### Features

- `baseUrl`: The base URL for all network requests.
- `connectTimeout` & `receiveTimeout`: Set request connection and receive timeouts.
- `headers`: Custom headers for all requests.

#### Example Usage

```dart
final options = DioOptions(
  baseUrl: 'https://api.example.com',
  connectTimeout: Duration(seconds: 10),
  receiveTimeout: Duration(seconds: 5),
);
```

## Energy Models

### EnergyType

The `EnergyType` enum defines different types of energy sources such as solar, house, and battery. Each type has an associated query parameter for use in data requests.

#### Example Usage

```dart
import 'models/energy.dart';

void main() {
  EnergyType energy = EnergyType.solar;
  print(energy.queryParam);  // Output: "solar"
}
```

### MonitoringModel

The `MonitoringModel` class represents a data point for monitoring energy. It contains the date of the reading and the value recorded.

#### Features

- `MonitoringModel.fromJson(Map<String, dynamic> json)`: Factory method to create a `MonitoringModel` instance from JSON data.

#### Example Usage

```dart
import 'models/monitoring_model.dart';

void main() {
  Map<String, dynamic> json = {'timestamp': '2024-11-23T10:00:00', 'value': 150};
  MonitoringModel model = MonitoringModel.fromJson(json);
  print(model.date);  // Output: 2024-11-23 10:00:00.000
  print(model.value); // Output: 150
}
```

### MetricUnit

`MetricUnit` is an abstract class that provides a structure for representing units of measurement, including a symbol and conversion rate.

### PowerUnit

The `PowerUnit` enum implements `MetricUnit` and represents different units of power, such as watts and kilowatts, with conversion factors.

#### Example Usage

```dart
import 'models/power_unit.dart';

void main() {
  PowerUnit unit = PowerUnit.kilowatts;
  print(unit.symbol);      // Output: "kWatts"
  print(unit.conversion);  // Output: 0.001
}
```

### PowerValue

The `PowerValue` class represents a power measurement, allowing conversion between units and formatted output.

#### Features

- `displayValue`: Converts the internal value in watts to the specified unit.
- `format()`: Formats the power value as a string, removing unnecessary decimal parts.
- `convertTo(PowerUnit newUnit)`: Returns a new `PowerValue` converted to the specified `PowerUnit`.

#### Example Usage

```dart
import 'models/power_value.dart';
import 'models/power_unit.dart';

void main() {
  PowerValue power = PowerValue(valueInWatts: 1500);
  print(power.format()); // Output: "1500"

  PowerValue convertedPower = power.convertTo(PowerUnit.kilowatts);
  print(convertedPower.format()); // Output: "1.5"
}
```

## Conclusion

The `monitoring_core` package is designed to make your Flutter development easier by providing a set of tools for dealing with dates, numbers, HTTP requests, and energy data. By incorporating useful extensions, leveraging the Dio package, and including data models for energy, it reduces the complexity of working with common functionality and helps keep your code clean and easy to maintain.

Feel free to explore and contribute to the package if you'd like to add more features or improve existing ones.

