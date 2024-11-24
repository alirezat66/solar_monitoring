// Mocks generated by Mockito 5.4.4 from annotations
// in solar_monitoring/test/features/theme/view/theme_mode_toggle_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:solar_monitoring/core/bloc/app_bloc.dart' as _i2;
import 'package:solar_monitoring/features/theme/model/theme_mode.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ThemeCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockThemeCubit extends _i1.Mock implements _i2.ThemeCubit {
  MockThemeCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.AppThemeMode get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i3.AppThemeMode.light,
      ) as _i3.AppThemeMode);

  @override
  _i4.Stream<_i3.AppThemeMode> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i3.AppThemeMode>.empty(),
      ) as _i4.Stream<_i3.AppThemeMode>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void toggleTheme() => super.noSuchMethod(
        Invocation.method(
          #toggleTheme,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i3.AppThemeMode? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i2.Change<_i3.AppThemeMode>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
