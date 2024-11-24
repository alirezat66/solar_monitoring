import 'package:solar_monitoring/features/theme/model/theme_mode.dart';

import '../../../core/bloc/app_bloc.dart';

class ThemeCubit extends Cubit<AppThemeMode> {
  ThemeCubit() : super(AppThemeMode.light);

  void toggleTheme() {
    emit(state == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light);
  }
}
