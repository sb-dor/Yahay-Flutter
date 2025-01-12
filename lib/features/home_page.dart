import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/global_data/models/bottom_navbar_item/bottom_navbar_item.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/authorization/view/bloc/auth_states.dart';
import 'package:yahay/features/chats/view/bloc/chats_bloc.dart';
import 'package:yahay/features/chats/view/bloc/chats_events.dart';
import 'package:yahay/features/chats/view/pages/chats_page.dart';
import 'package:yahay/features/contacts/view/contacts_page.dart';
import 'package:yahay/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/features/profile/view/pages/profile_page.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription _authStreamListener;
  late List<BottomNavbarItem> _screens = [];
  ChatsBloc? _chatsBloc;
  late final AuthBloc _authBloc;
  int _index = 1;

  @override
  void initState() {
    super.initState();
    _authBloc = DependenciesScope.of(context, listen: false).authBloc;
    _chatsBloc = DependenciesScope.of(context, listen: false).chatsBloc;

    _authStreamListener = _authBloc.states.listen((authState) {
      if (authState is UnAuthorizedState) {
        AutoRouter.of(context).replaceAll([const LoginRoute()]);
      }
    });

    _screens = [
      const BottomNavbarItem(
        screen: ContactsPage(),
        icon: Icon(
          Icons.people_outline,
          size: 28,
        ),
        label: Constants.contacts,
      ),
      const BottomNavbarItem(
        screen: ChatsPage(),
        icon: Icon(
          CupertinoIcons.chat_bubble_2,
          size: 28,
        ),
        label: Constants.chats,
      ),
      const BottomNavbarItem(
        screen: ProfilePage(),
        icon: Icon(
          Icons.person,
          size: 28,
        ),
        label: Constants.profile,
      ),
    ];
  }

  @override
  void deactivate() {
    debugPrint("home page deactivate worked");
    _authStreamListener.cancel();
    _chatsBloc?.events.add(ChangeToLoadingState());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int index) => setState(() => _index = index),
        unselectedLabelStyle: GoogleFonts.aBeeZee(),
        selectedLabelStyle: GoogleFonts.aBeeZee(),
        items: _screens
            .map((e) => BottomNavigationBarItem(
                  icon: e.icon,
                  label: e.label,
                ))
            .toList(),
      ),
      body: _screens[_index].screen,
    );
  }
}
