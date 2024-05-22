import 'package:flutter/material.dart';
import 'package:yahay/features/profile/view/bloc/profile_bloc.dart';
import 'package:yahay/features/profile/view/bloc/profile_events.dart';
import 'package:yahay/injections/injections.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = snoopy<ProfileBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () => _profileBloc.events.add(ProfileLogoutEvent()),
            child: Icon(Icons.logout)),
      ),
    );
  }
}
