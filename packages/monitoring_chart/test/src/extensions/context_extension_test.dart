import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

void main() {
  testWidgets('ContextExt provides theme properties', (tester) async {
    const chartTheme = ChartThemeExtension(
      lineColor: Colors.blue,
      lineWidth: 2,
      areaGradient: LinearGradient(colors: [Colors.blue, Colors.white]),
      horizontalGridLineColor: Colors.grey,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [chartTheme],
        ),
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(400, 800), // Portrait dimensions
          ),
          child: Builder(
            builder: (context) {
              expect(context.colorScheme, isA<ColorScheme>());
              expect(context.textTheme, isA<TextTheme>());
              expect(context.chartTheme, equals(chartTheme));
              expect(context.orientation, Orientation.portrait);
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  });

  testWidgets('ContextExt handles different orientations', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 600)); // Landscape

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            expect(context.orientation, Orientation.landscape);
            return const SizedBox();
          },
        ),
      ),
    );
  });

  testWidgets('ContextExt throws when chart theme is missing', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            expect(
              () => context.chartTheme,
              throwsA(isA<TypeError>()), // Null check operator error
            );
            return const SizedBox();
          },
        ),
      ),
    );
  });
}
