import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:yahay/features/chats/view/bloc/chats_bloc.dart';
import 'package:yahay/features/chats/view/bloc/chats_events.dart';
import 'package:yahay/injections/injections.dart';
import 'chats_appbar/chats_appbar.dart';

@RoutePage()
class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late final ChatsBloc _chatsBloc;

  @override
  void initState() {
    super.initState();
    _chatsBloc = snoopy<ChatsBloc>();
    _chatsBloc.events.add(GetUserChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        child: const ChatsAppbar(),
      ),
    );
  }
}
