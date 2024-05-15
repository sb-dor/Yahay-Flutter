import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_events.dart';
import 'package:yahay/features/chat_screen/view/pages/bottom_chat_widget/bottom_chat_widget.dart';
import 'package:yahay/injections/injections.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final Chat? chat;
  final User? user; // temp for creating temp chat if chat does not exist

  const ChatScreen({
    super.key,
    required this.chat,
    required this.user,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatScreenBloc _chatScreenBloc;

  @override
  void initState() {
    super.initState();
    _chatScreenBloc = snoopy<ChatScreenBloc>();
    _chatScreenBloc.events.add(InitChatScreenEvent(
      widget.chat,
      widget.user,
      _chatScreenBloc.events,
    ));
  }

  @override
  void dispose() {
    _chatScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _chatScreenBloc.events.add(RemoveAllTempCreatedChatsEvent());
            AutoRouter.of(context).maybePop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [],
            ),
          ),
          BottomChatWidget(),
        ],
      ),
    );
  }
}
