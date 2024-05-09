import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/global_data/models/bottom_navbar_item/bottom_navbar_item.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/features/chats/view/chats_page.dart';
import 'package:yahay/features/contacts/view/contacts_page.dart';
import 'package:yahay/features/profile/view/profile_page.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<BottomNavbarItem> _screens = [];
  int _index = 1;

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int index) => setState(() => _index = index),
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
