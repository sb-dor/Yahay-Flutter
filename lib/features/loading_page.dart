import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/features/chats/view/chats_page.dart';
import 'package:yahay/injections/injections.dart';

import 'authorization/view/bloc/auth_bloc.dart';
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
    _authBloc = snoopy<AuthBloc>();

    _streamSubscription = _authBloc.states.listen((state) {
      if (state is AuthorizedState) {
        AutoRouter.of(context).replaceAll([const HomeRoute()]);
      } else if (state is UnAuthorizedState) {
        AutoRouter.of(context).replaceAll([const LoginRoute()]);
      } else if (state is ErrorAuthState) {
      } else {}
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
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
