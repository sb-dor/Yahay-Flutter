import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_usages/widgets/shimmer_loader.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_events.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_states.dart';
import 'package:yahay/features/chat_screen/view/bloc/state_model/chat_screen_state_model.dart';

class ChatScreenAppBar extends StatefulWidget {
  final ThemeData themeData;
  final ChatScreenBloc chatScreenBloc;
  final Chat? chat;

  const ChatScreenAppBar({
    super.key,
    required this.chatScreenBloc,
    required this.themeData,
    required this.chat,
  });

  @override
  State<ChatScreenAppBar> createState() => _ChatScreenAppBarState();
}

class _ChatScreenAppBarState extends State<ChatScreenAppBar> {
  late final ChatScreenBloc _chatScreenBloc;
  late final ChatScreenStateModel _chatScreenStateModel;

  @override
  void initState() {
    super.initState();
    _chatScreenBloc = widget.chatScreenBloc;
    _chatScreenStateModel = widget.chatScreenBloc.states.value.chatScreenStateModel;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      leading: IconButton(
        onPressed: () {
          _chatScreenBloc.events.add(RemoveAllTempCreatedChatsEvent());
          AutoRouter.of(context).maybePop();
        },
        icon: const Icon(CupertinoIcons.back),
      ),
      title: _chatScreenBloc.states.value is LoadingChatScreenState
          ? ShimmerLoader(
              isLoading: true,
              mode: widget.themeData,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
              ),
            )
          : _ChatAppBarTitle(
              chat: _chatScreenStateModel.currentChat,
            ),
      actions: _chatScreenBloc.states.value is LoadingChatScreenState
          ? [
              ShimmerLoader(
                isLoading: true,
                mode: widget.themeData,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ]
          : [
              IconButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    VideoChatFeatureRoute(
                      chat: _chatScreenStateModel.currentChat,
                    ),
                  );
                },
                icon: Icon(
                  CupertinoIcons.videocam,
                  color:
                      _chatScreenStateModel.currentChat?.videoChatRoom != null ? Colors.green : null,
                ),
              ),
            ],
    );
  }
}

class _ChatAppBarTitle extends StatelessWidget {
  final Chat? chat;

  const _ChatAppBarTitle({
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    if ((chat?.participants?.length ?? 0) > 1) {
      return Text(chat?.name ?? '');
    } else {
      return Text(chat?.participants?.firstOrNull?.user?.name ??
          chat?.participants?.firstOrNull?.user?.email ??
          '-');
    }
  }
}
