import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/global_usages/widgets/shimmer_loader.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_events.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_states.dart';

class ChatScreenAppBar extends StatelessWidget {
  final ChatScreenBloc chatScreenBloc;

  const ChatScreenAppBar({
    super.key,
    required this.chatScreenBloc,
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
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
              ),
            )
          : Text("${chatScreenBloc.states.value.chatScreenStateModel.currentChat?.name}"),
    );
  }
}
