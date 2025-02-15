import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/core/models/bottom_navbar_item/bottom_navbar_item.dart';
import 'package:yahay/src/features/chats/bloc/chats_bloc.dart';
import 'package:yahay/src/features/chats/view/chats_page.dart';
import 'package:yahay/src/features/contacts/view/contacts_page.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/src/features/profile/view/profile_page.dart';
import 'authorization/bloc/auth_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<BottomNavbarItem> _screens = [];
  late final ChatsBloc? _chatsBloc;
  late final AuthBloc _authBloc;
  int _index = 1;

  @override
  void initState() {
    super.initState();
    _authBloc = DependenciesScope.of(context, listen: false).authBloc;
    _chatsBloc = DependenciesScope.of(context, listen: false).chatsBloc;

    if (_chatsBloc != null) {
      _chatsBloc.add(const ChatsEvents.getUserChatsEvent());
      _chatsBloc.add(const ChatsEvents.chatListenerInitialEvent());
    }

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
    _chatsBloc?.add(const ChatsEvents.changeToLoadingState());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is Auth$UnAuthorizedState) {
          AutoRouter.of(context).replaceAll([const LoginRoute()]);
        }
      },
      builder: (context, state) {
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
                    ),)
                .toList(),
          ),
          body: _screens[_index].screen,
        );
      },
    );
  }
}
