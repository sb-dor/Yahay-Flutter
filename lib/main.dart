import 'package:flutter/material.dart';
import 'package:yahay/core/app_settings/app_theme/app_theme_bloc.dart';
import 'package:yahay/core/utils/global_context/global_context.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/authorization/view/bloc/auth_events.dart';
import 'package:yahay/features/authorization/view/bloc/auth_states.dart';
import 'package:yahay/features/authorization/view/pages/register_page.dart';
import 'package:yahay/features/chats/view/chats_page.dart';
import 'package:yahay/injections/injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return StreamBuilder<ThemeData>(
      stream: _appThemeBloc.theme,
      builder: (context, themeStates) {
        return StreamBuilder<AuthStates>(
          stream: _authBloc.states,
          builder: (context, authStates) {
            late Widget child;
            if (authStates.data is LoadingAuthState) {
              child = Container();
            } else if (authStates.data is UnAuthorizedState) {
              child = const RegisterPage();
            } else if (authStates.data is ErrorAuthState) {
              child = Container();
            } else {
              child = const ChatsPage();
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeStates.data,
              navigatorKey: snoopy<GlobalContext>().globalContext,
              home: child,
            );
          },
        );
      },
    );
  }
}
