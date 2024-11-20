// test/core/bloc/app_bloc_observer_test.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitoring/core/bloc/bloc_observer.dart';

class TestBloc extends Bloc<String, int> {
  TestBloc() : super(0) {
    on<String>((event, emit) {
      if (event == 'increment') {
        emit(state + 1);
      } else if (event == 'error') {
        addError(Exception('test error'));
      }
    });
  }
}

void main() {
  late AppBlocObserver observer;
  late TestBloc bloc;

  setUp(() {
    observer = AppBlocObserver();
    bloc = TestBloc();
  });

  tearDown(() {
    bloc.close();
  });

  // Individual method tests remain the same...

  group('Integration tests', () {
    test('observer catches all bloc lifecycle events', () async {
      final prints = <String>[];
      debugPrint = (String? message, {int? wrapWidth}) {
        prints.add(message!);
      };

      Bloc.observer = observer;

      final testBloc = TestBloc();
      await Future<void>.delayed(Duration.zero); // Wait for creation

      testBloc.add('increment');
      await Future<void>.delayed(Duration.zero); // Wait for increment

      testBloc.add('error');
      await Future<void>.delayed(Duration.zero); // Wait for error

      await testBloc.close();
      await Future<void>.delayed(Duration.zero); // Wait for close

      // Verify the actual order of events
      expect(prints, [
        contains('onCreate -- bloc: TestBloc'),
        contains('onEvent -- bloc: TestBloc, event: increment'),
        contains('onTransition -- bloc: TestBloc'),
        contains('onChange -- bloc: TestBloc'),
        contains('onEvent -- bloc: TestBloc, event: error'),
        contains('onError -- bloc: TestBloc'),
        contains('onClose -- bloc: TestBloc'),
      ]);
    });

    test('observer follows correct event order for single event', () async {
      final eventOrder = <String>[];
      debugPrint = (String? message, {int? wrapWidth}) {
        if (message != null) {
          eventOrder.add(message.split(' -- ').first);
        }
      };

      Bloc.observer = observer;

      final testBloc = TestBloc();
      await Future<void>.delayed(Duration.zero);

      testBloc.add('increment');
      await Future<void>.delayed(Duration.zero);

      await testBloc.close();
      await Future<void>.delayed(Duration.zero);

      expect(eventOrder, [
        'onCreate',
        'onEvent',
        'onTransition',
        'onChange',
        'onClose',
      ]);
    });
  });

  test('observer handles errors correctly', () async {
    final prints = <String>[];
    debugPrint = (String? message, {int? wrapWidth}) {
      prints.add(message!);
    };

    Bloc.observer = observer;

    final testBloc = TestBloc();
    await Future<void>.delayed(Duration.zero);

    testBloc.add('error');
    await Future<void>.delayed(Duration.zero);

    await testBloc.close();

    expect(
      prints,
      containsAllInOrder([
        contains('onCreate'),
        contains('onEvent'),
        contains('onError'),
      ]),
    );
  });
}
