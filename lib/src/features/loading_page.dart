import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'authorization/view/bloc/auth_bloc.dart';
import 'authorization/view/bloc/auth_events.dart';
import 'authorization/view/bloc/auth_states.dart';

@RoutePage()
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoadingPage> {
  late final AuthBloc _authBloc;
  late final StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    final depContainer = DependenciesScope.of(context, listen: false);
    _authBloc = depContainer.authBloc;
    _authBloc.events.add(
      CheckAuthEvent(
        initChatsBloc: () {
          depContainer.initChatBlocAfterAuthorization();
        },
      ),
    );

    _streamSubscription = _authBloc.states.listen((state) async {
      if (state is AuthorizedState) {
        AutoRouter.of(context).replaceAll([const HomeRoute()]);
      } else if (state is UnAuthorizedState) {
        AutoRouter.of(context).replaceAll([const LoginRoute()]);
      } else if (state is ErrorAuthState) {
      } else {
        // TODO something on error state
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  void deactivate() {
    _streamSubscription.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
