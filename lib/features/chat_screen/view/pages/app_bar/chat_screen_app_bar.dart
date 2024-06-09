import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_usages/widgets/shimmer_loader.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_events.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_states.dart';

class ChatScreenAppBar extends StatelessWidget {
  final ThemeData themeData;
  final ChatScreenBloc chatScreenBloc;

  const ChatScreenAppBar({
    super.key,
    required this.chatScreenBloc,
    required this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      leading: IconButton(
        onPressed: () {
          chatScreenBloc.events.add(RemoveAllTempCreatedChatsEvent());
          AutoRouter.of(context).maybePop();
        },
        icon: const Icon(CupertinoIcons.back),
      ),
      title: chatScreenBloc.states.value is LoadingChatScreenState
          ? ShimmerLoader(
              isLoading: true,
              mode: themeData,
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
              chat: chatScreenBloc.states.value.chatScreenStateModel.currentChat,
            ),
      actions: chatScreenBloc.states.value is LoadingChatScreenState
          ? [
              ShimmerLoader(
                isLoading: true,
                mode: themeData,
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
                      chat: chatScreenBloc.states.value.chatScreenStateModel.currentChat,
                    ),
                  );
                },
                icon: const Icon(CupertinoIcons.videocam),
              ),
            ],
    );
  }
}

class _ChatAppBarTitle extends StatelessWidget {
  final Chat? chat;

  const _ChatAppBarTitle({
    super.key,
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
