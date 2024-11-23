# Monitoring Core

This package, `monitoring_core`, provides various utilities and helper classes, including extensions for date and number manipulation as well as a network client implementation using `Dio`. This package aims to simplify development by providing common utilities for handling dates, numbers, and HTTP requests.

## Features Overview

- **Date & Number Extensions**: Useful methods for working with `DateTime` and `num` to make code more concise and readable.
- **Network Client with Dio**: A wrapper around the `Dio` package that makes HTTP requests easier and more structured.

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

## Conclusion

The `monitoring_core` package is designed to make your Flutter development easier by providing a set of tools for dealing with dates, numbers, and HTTP requests. By incorporating useful extensions and leveraging the Dio package, it reduces the complexity of working with common functionality and helps keep your code clean and easy to maintain.

Feel free to explore and contribute to the package if you'd like to add more features or improve existing ones.

