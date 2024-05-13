import 'package:flutter/material.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_events.dart';
import 'package:yahay/injections/injections.dart';

class ChatScreen extends StatefulWidget {
  final Chat? chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatScreenBloc _chatScreenBloc;

  @override
  void initState() {
    super.initState();
    _chatScreenBloc = snoopy<ChatScreenBloc>();
    _chatScreenBloc.events.add(InitChatScreenEvent(widget.chat, _chatScreenBloc.events));
  }

  @override
  void dispose() {
    _chatScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
