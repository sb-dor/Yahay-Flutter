import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/ui_kit/shimmer_loader.dart';
import 'package:yahay/src/features/chat_screen/bloc/chat_screen_bloc.dart';

class ChatScreenAppBar extends StatefulWidget {
  final ThemeData themeData;
  final ChatModel? chat;

  const ChatScreenAppBar({
    super.key,
    required this.themeData,
    required this.chat,
  });

  @override
  State<ChatScreenAppBar> createState() => _ChatScreenAppBarState();
}

class _ChatScreenAppBarState extends State<ChatScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatScreenBloc, ChatScreenStates>(
      builder: (context, state) {
        final currentStateModel = state.chatScreenStateModel;
        return AppBar(
          scrolledUnderElevation: 0.0,
          leading: IconButton(
            onPressed: () {
              AutoRouter.of(context).maybePop();
              // Future.delayed(const Duration(milliseconds: 10), () {
              //   if (!currentStateModel.showEmojiPicker) {
              //     context
              //         .read<ChatScreenBloc>()
              //         .add(const ChatScreenEvents.removeAllTempCreatedChatsEvent());
              //     if (context.mounted) {
              //       AutoRouter.of(context).maybePop();
              //     }
              //   }
              // });
            },
            icon: const Icon(CupertinoIcons.back),
          ),
          title:
              state is ChatScreen$InProgressState
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
                  : _ChatAppBarTitle(chat: currentStateModel.currentChat),
          actions:
              state is ChatScreen$InProgressState
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
                            chat: currentStateModel.currentChat,
                          ),
                        );
                      },
                      icon: Icon(
                        CupertinoIcons.videocam,
                        color:
                            (currentStateModel
                                        .currentChat
                                        ?.videoChatStreaming ??
                                    false)
                                ? Colors.green
                                : null,
                      ),
                    ),
                  ],
        );
      },
    );
  }
}

class _ChatAppBarTitle extends StatelessWidget {
  final ChatModel? chat;

  const _ChatAppBarTitle({required this.chat});

  @override
  Widget build(BuildContext context) {
    if ((chat?.participants?.length ?? 0) > 1) {
      return Text(chat?.name ?? '');
    } else {
      return Text(
        chat?.participants?.firstOrNull?.user?.name ??
            chat?.participants?.firstOrNull?.user?.email ??
            '-',
      );
    }
  }
}
