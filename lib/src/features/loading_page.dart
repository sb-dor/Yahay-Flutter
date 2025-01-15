import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'authorization/bloc/auth_bloc.dart';

@RoutePage()
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoadingPage> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    final depContainer = DependenciesScope.of(context, listen: false);
    _authBloc = depContainer.authBloc;
    _authBloc.add(
      AuthEvents.checkAuthEvent(
        initChatsBloc: () {
          depContainer.initChatBlocAfterAuthorization();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthorizedStateOnAuthStates) {
          AutoRouter.of(context).replaceAll([const HomeRoute()]);
        } else if (state is UnAuthorizedStateOnAuthStates) {
          AutoRouter.of(context).replaceAll([const LoginRoute()]);
        } else if (state is ErrorStateOnAuthStates) {
        } else {
          // TODO something on error state
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
