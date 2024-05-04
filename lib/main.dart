import 'package:flutter/material.dart';
import 'package:yahay/core/app_settings/app_theme/app_theme_bloc.dart';
import 'package:yahay/core/utils/global_context/global_context.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/authorization/view/bloc/auth_events.dart';
import 'package:yahay/injections/injections.dart';

void main() async {
  await Injections.init();

  runApp(const Yahay());
}

class Yahay extends StatefulWidget {
  const Yahay({super.key});

  @override
  State<Yahay> createState() => _YahayState();
}

class _YahayState extends State<Yahay> {
  late final AppThemeBloc _appThemeBloc;
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _appThemeBloc = snoopy<AppThemeBloc>();
    _authBloc = snoopy<AuthBloc>();

    _authBloc.events.add(CheckAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _appThemeBloc.theme,
      builder: (context, snapShot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: snapShot.data,
          navigatorKey: snoopy<GlobalContext>().globalContext,
        );
      },
    );
  }
}
