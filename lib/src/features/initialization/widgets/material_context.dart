import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeData>(
      stream: DependenciesScope.of(context).appThemeBloc.theme,
      builder: (context, themeStates) {
        return MaterialApp.router(
          // scaffoldMessengerKey: snoopy<GlobalContext>().globalContext,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale("en"),
          supportedLocales: const [
            Locale("ru"),
            Locale("en"),
          ],
          debugShowCheckedModeBanner: false,
          theme: themeStates.data,
          // if you will use the auto_route package in order to navigate between screens without context
          // navigatorKey is already set in autoRouter
          // the only thing that you have to do is
          // setting "_appRouter" globally
          // like singlton
          // example:
          // snoopy<AppRouter>().push(route)
          routerConfig: DependenciesScope.of(context).appRouter.config(),
          // about deeplinking have a look this doc:
          // https://pub.dev/packages/auto_route#deep-linking
        );
      },
    );
  }
}
