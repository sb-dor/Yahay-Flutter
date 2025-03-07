import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
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

  void _onMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    final depContainer = DependenciesScope.of(context, listen: false);
    _authBloc = depContainer.authBloc;
    _authBloc.add(
      AuthEvents.checkAuthEvent(
        initDependenciesAfterAuthorization:
            depContainer.initDependenciesAfterAuthorization,
        onMessage: _onMessage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is Auth$AuthorizedState) {
          AutoRouter.of(context).replaceAll([const HomeRoute()]);
        } else if (state is Auth$UnAuthorizedState) {
          AutoRouter.of(context).replaceAll([const LoginRoute()]);
        } else if (state is ErrorStateOnAuthStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(Constants.somethingWentWrong)),
          );
        } else {
          // TODO something on error state
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
