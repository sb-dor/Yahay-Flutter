import 'package:flutter/material.dart';
import 'package:yahay/src/features/authorization/bloc/auth_bloc.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/src/features/profile/bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileBloc _profileBloc;
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = DependenciesScope.of(context, listen: false).authBloc;
    _profileBloc = DependenciesScope.of(context, listen: false).profileBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _profileBloc.add(
            ProfileEvents.profileLogoutEvent(
              () {
                _authBloc.add(const AuthEvents.logOutEvent());
              },
            ),
          ),
          child: const Icon(Icons.logout),
        ),
      ),
    );
  }
}
