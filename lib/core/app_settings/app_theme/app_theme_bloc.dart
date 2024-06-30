import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/core/app_settings/app_theme/app_colors_scheme.dart';

@immutable
abstract class AppThemeEvents {
  const AppThemeEvents();
}

@immutable
class AppThemeChangerEvent extends AppThemeEvents {
  const AppThemeChangerEvent();
}

@immutable
class AppThemeBloc {
  static late final ThemeData _currentState;
  final Sink<AppThemeEvents> events;
  final BehaviorSubject<ThemeData> _theme;

  BehaviorSubject<ThemeData> get theme => _theme;

  const AppThemeBloc._({
    required this.events,
    required BehaviorSubject<ThemeData> theme,
  }) : _theme = theme;

  factory AppThemeBloc() {
    final eventBehavior = BehaviorSubject<AppThemeEvents>();

    _currentState = AppColorsScheme.light;

    final themeData = eventBehavior.map<ThemeData>((appThemeDataEvent) {
      ThemeData theme = _appThemeChangerEvent(appThemeDataEvent as AppThemeChangerEvent);
      return theme;
    }).startWith(_currentState);

    final BehaviorSubject<ThemeData> themeDataStream = BehaviorSubject<ThemeData>()
      ..addStream(themeData);

    return AppThemeBloc._(events: eventBehavior.sink, theme: themeDataStream);
  }

  static ThemeData _appThemeChangerEvent(AppThemeChangerEvent event) {
    switch (_currentState.brightness) {
      case Brightness.dark:
        return AppColorsScheme.light;
      case Brightness.light:
        return AppColorsScheme.dark;
      default:
        return AppColorsScheme.dark;
    }
  }
}
