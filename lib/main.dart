import 'package:flutter/material.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/app_settings/app_theme/app_theme_bloc.dart';
import 'package:yahay/core/utils/global_context/global_context.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/authorization/view/bloc/auth_events.dart';
import 'package:yahay/features/authorization/view/bloc/auth_states.dart';
import 'package:yahay/features/chats/view/chats_page.dart';
import 'package:yahay/injections/injections.dart';
import 'features/authorization/view/pages/login_page.dart';

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
  final _appRouter = AppRouter();
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
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: themeStates.data,
          scaffoldMessengerKey: snoopy<GlobalContext>().globalContext,
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
