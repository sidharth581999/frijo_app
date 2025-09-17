import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/app_theme.dart';
import 'package:frijo/application/core/utils/enums.dart';

class ThemeCubit extends Cubit<AppThemeMode> {
  ThemeCubit() : super(AppThemeMode.light);

  void toggleTheme() {
    if (state == AppThemeMode.light) {
      emit(AppThemeMode.dark);
    } else {
      emit(AppThemeMode.light);
    }
  }

  void setTheme(AppThemeMode mode) {
    emit(mode);
  }

  ThemeData get themeData => AppTheme.getTheme(state);
}
