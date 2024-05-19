import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/app_settings/app_theme/app_theme_bloc.dart';
import 'package:yahay/core/utils/global_context/global_context.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/authorization/view/bloc/auth_events.dart';
import 'package:yahay/injections/injections.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeData>(
      stream: _appThemeBloc.theme,
      builder: (context, themeStates) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: themeStates.data,
          // if you will use the auto_route package in order to navigate between screens without context
          // navigatorKey is already set in autoRouter
          // the only thing that you have to do is
          // setting "_appRouter" globally
          // like singlton
          // example:
          // snoopy<AppRouter>().push(route)
          routerConfig: snoopy<AppRouter>().config(),
          // about deeplinking have a look this doc:
          // https://pub.dev/packages/auto_route#deep-linking
        );
      },
    );
  }
}
