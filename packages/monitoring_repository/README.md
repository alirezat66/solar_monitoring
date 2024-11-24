# Monitoring Repository

The `monitoring_repository` package provides an implementation of a repository for fetching energy monitoring data. It acts as an abstraction layer between the data source and the application, making it easier to retrieve monitoring data while keeping your code organized and decoupled from the underlying data fetching mechanisms.

This repository relies on the `monitoring_core` package to use models, extensions, and network client utilities.

## Features Overview

- **Data Retrieval**: Retrieve energy monitoring data for specific dates and energy types.
- **Network Client Integration**: Uses `NetworkClient` from `monitoring_core` for making API requests.
- **Cache Management**: Reset the cache to clear stored monitoring data.

## MonitoringRepositoryImpl

The `MonitoringRepositoryImpl` class implements the `MonitoringRepository` interface and provides an easy-to-use method for retrieving monitoring data for a given energy type and date.

### Features

- `getMonitoringData({required DateTime date, required EnergyType type, bool resetCache = false})`: Fetches energy monitoring data for the specified date and energy type. The `resetCache` parameter can be used to reset the cache before fetching data.
- `resetCache()`: Resets the cache to clear stored monitoring data.
- `clearCache()`: Clears the cache.

### Example Usage

To use `MonitoringRepositoryImpl`, you need to provide a `NetworkClient` instance. This example demonstrates how to use the repository to get monitoring data.

```dart
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_repository/monitoring_repository.dart';

void main() async {
  final options = DioOptions(baseUrl: 'https://api.example.com');
  final client = DioClient(options: options);
  final repository = MonitoringRepositoryImpl(client: client);

  try {
    final data = await repository.getMonitoringData(
      date: DateTime.now(),
      type: EnergyType.solar,
      resetCache: true,
    );
    for (var item in data) {
      print('Date: ${item.date}, Value: ${item.value}');
    }
  } catch (e) {
    print('Error fetching monitoring data: $e');
  }

  // Reset the cache
  repository.resetCache();

  // Clear the cache
  repository.clearCache();
}
```

## Classes

### MonitoringRepositoryImpl

`MonitoringRepositoryImpl` is a concrete implementation of the `MonitoringRepository` interface, responsible for retrieving monitoring data using the provided `NetworkClient`.

#### Constructor

- `MonitoringRepositoryImpl({required NetworkClient client, String apiPath = '/monitoring'})`: Initializes the repository with the specified network client and an optional API path.

#### Methods

- `Future<List<MonitoringModel>> getMonitoringData({required DateTime date, required EnergyType type, bool resetCache = false})`: This method makes a network call using the provided `NetworkClient` to fetch a list of `MonitoringModel` objects for the given date and energy type. The `resetCache` parameter can be used to reset the cache before fetching data.
- `void resetCache()`: This method resets the cache to clear stored monitoring data.
- `void clearCache()`: This method clears the cache.

## Dependencies

This package relies on the following:

- **monitoring_core**: Provides the `MonitoringModel`, `EnergyType`, `NetworkClient`, and `DateExtension`.
- **Dio**: Used through `DioClient` to make HTTP requests.

## Conclusion

The `monitoring_repository` package simplifies the process of retrieving monitoring data by providing a repository pattern implementation that integrates with `monitoring_core` for networking and data modeling. This keeps the code modular, making it easier to manage and test.

Feel free to explore and contribute to the package if you'd like to add more features or improve existing ones.

