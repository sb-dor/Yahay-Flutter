import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/src/features/app_theme/models/app_colors_scheme.dart';

@immutable
abstract class AppThemeEvents {
  const AppThemeEvents();
}

@immutable
sealed class AppThemeChangerEvent extends AppThemeEvents {
  const AppThemeChangerEvent();
}

@immutable
class AppThemeBloc {
  static late final ThemeData _currentState;
  final Sink<AppThemeEvents> events;
  final BehaviorSubject<ThemeData> _theme;

  BehaviorSubject<ThemeData> get theme => _theme;

  const AppThemeBloc._({required this.events, required BehaviorSubject<ThemeData> theme})
    : _theme = theme;

  factory AppThemeBloc() {
    final eventBehavior = BehaviorSubject<AppThemeEvents>();

    _currentState = AppColorsScheme.light;

    final themeData = eventBehavior
        .map<ThemeData>((appThemeDataEvent) {
          final ThemeData theme = _appThemeChangerEvent(appThemeDataEvent as AppThemeChangerEvent);
          return theme;
        })
        .startWith(_currentState);

    final BehaviorSubject<ThemeData> themeDataStream =
        BehaviorSubject<ThemeData>()..addStream(themeData);

    return AppThemeBloc._(events: eventBehavior.sink, theme: themeDataStream);
  }

  static ThemeData _appThemeChangerEvent(AppThemeChangerEvent event) {
    switch (_currentState.brightness) {
      case Brightness.dark:
        return AppColorsScheme.light;
      case Brightness.light:
        return AppColorsScheme.dark;
    }
  }
}
