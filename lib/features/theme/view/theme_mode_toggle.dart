import 'package:flutter/material.dart';
import 'package:solar_monitoring/core/bloc/app_bloc.dart';
import 'package:solar_monitoring/features/theme/model/theme_mode.dart';

class ThemeModeToggle extends StatelessWidget {
  const ThemeModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, AppThemeMode>(
      builder: (context, themeMode) {
        return IconButton(
          icon: Icon(
            themeMode == AppThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
        );
      },
    );
  }
}
