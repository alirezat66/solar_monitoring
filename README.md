# Solar Monitoring

Solar Monitoring is a Flutter project designed to monitor and visualize energy data from various sources such as solar panels, batteries, and house consumption. The project is composed of multiple packages that provide utilities, data models, charting capabilities, and repository patterns for fetching and displaying energy data.

## Description

This application is developed for testing purposes, focusing on **Structure**. The application is developed using **Bloc** state management. The goal is to implement the architecture part maintainable, expandable and reusable. The application fetches random estate info from a Docker server and displays line chart.

## Some Info About the Project

[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Maintain Status](https://img.shields.io/badge/Maintained%3F-no-red.svg)]()
[![Ask me](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](https://alirezat66.github.io/)

## Tech Stack

**Language:** Dart

**Platform:** Flutter

**Rest Client:** Dio

**State Management:** Bloc

**Chart:** FlChart

## Features

- Light/dark mode toggle
- Unit selector
- Caching
- Pull to refresh

## Demo

![myfile](https://github.com/alirezat66/solar_monitoring/blob/master/assets/demo.gif)

## Color Reference

| Color             | Hex                                                                |
| ----------------- | ------------------------------------------------------------------ |
| Dot Main Color (Light) | ![#E5D9F6](https://via.placeholder.com/10/E5D9F6?text=+) #E5D9F6 |
| Dot Main Color (Dark)  | ![#6200EE](https://via.placeholder.com/10/6200EE?text=+) #6200EE |
| Dot Border Color (Light) | ![#FFFFFF](https://via.placeholder.com/10/FFFFFF?text=+) #FFFFFF |
| Dot Border Color (Dark)  | ![#000000](https://via.placeholder.com/10/000000?text=+) #000000 |
| Dot Secondary Color (Light) | ![#4F5D75](https://via.placeholder.com/10/4F5D75?text=+) #4F5D75 |

## The Main Problems

Make FLChart intervals fit.
In other hand I tried to make application independent to Chart Package, it means you can easily change flchart to other chart easily, without affecting the app, you can also replace Dio with anything that you want without challenging.

## Packages

### monitoring_core

The `monitoring_core` package provides various utilities and helper classes, including extensions for date and number manipulation, network client implementation using `Dio`, models for handling energy data and metrics, and properties for managing UI tabs related to energy sources.

[Read more](packages/monitoring_core/README.md)

### monitoring_repository

The `monitoring_repository` package provides data to us and cache them.

[Read more](packages/monitoring_repository/README.md)

### monitoring_repository

The `monitoring_chart` package provide line chart to us. we just need to send data and unit to this package.

[Read more](packages/monitoring_chart/README.md)
