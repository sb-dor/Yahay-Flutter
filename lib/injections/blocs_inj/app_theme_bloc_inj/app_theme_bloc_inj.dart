import 'package:yahay/core/app_settings/app_theme/app_theme_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class AppThemeBlocInj {
  static Future<void> appThemeBlocInj() async =>
      snoopy.registerLazySingleton<AppThemeBloc>(() => AppThemeBloc());
}
