import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_usages/widgets/shimmer_loader.dart';
import 'package:yahay/src/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/src/features/chat_screen/view/bloc/chat_screen_events.dart';
import 'package:yahay/src/features/chat_screen/view/bloc/chat_screen_states.dart';
import 'package:yahay/src/features/chat_screen/view/bloc/state_model/chat_screen_state_model.dart';
import 'package:yahay/src/features/chat_screen/view/pages/app_bar/chat_screen_app_bar.dart';
import 'package:yahay/src/features/chat_screen/view/pages/bottom_chat_widget/bottom_chat_widget.dart';
import 'package:yahay/src/features/chat_screen/view/pages/bottom_chat_widget/emoji_picker_helper.dart';
import 'package:yahay/src/features/chat_screen/view/pages/message_widget/loading_messages_widget.dart';
import 'package:yahay/src/features/chat_screen/view/pages/message_widget/message_widget.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/chat_screen_bloc_factory.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';

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
  late final AppThemeBloc _appThemeBloc;
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    final dependencyContainer = DependenciesScope.of(context, listen: false);
    currentUser = dependencyContainer.authBloc.states.value.authStateModel.user;


    _chatScreenBloc = ChatScreenBlocFactory(
      currentUser,
      dependencyContainer.pusherClientService.options,
    ).create();
    _appThemeBloc = dependencyContainer.appThemeBloc;
    //
    //
    _chatScreenBloc.events.add(
      InitChatScreenEvent(
        widget.chat,
        widget.user,
        _chatScreenBloc.events,
      ),
    );
  }

  @override
  void dispose() {
    _chatScreenBloc.events.add(RemoveAllTempCreatedChatsEvent());
    _chatScreenBloc.dispose();
    super.dispose();
  }

  void _emojiClearHelper(ChatScreenStateModel currentStateModel) {
    if (currentStateModel.showEmojiPicker) {
      _chatScreenBloc.events.add(ChangeEmojiPicker(value: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatScreenStates>(
      stream: _chatScreenBloc.states,
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const SizedBox();
          case ConnectionState.active:
          case ConnectionState.done:
            final currentState = snap.requireData;
            final currentStateModel = currentState.chatScreenStateModel;
            return PopScope(
              canPop: !currentStateModel.showEmojiPicker,
              onPopInvoked: (v) => _emojiClearHelper(currentStateModel),
              child: GestureDetector(
                onTap: () => _emojiClearHelper(currentStateModel),
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
                    child: ChatScreenAppBar(
                      chatScreenBloc: _chatScreenBloc,
                      themeData: _appThemeBloc.theme.value,
                      chat: widget.chat,
                    ),
                  ),
                  body: ShimmerLoader(
                    isLoading: currentState is LoadingChatScreenState,
                    mode: _appThemeBloc.theme.value,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            reverse: true,
                            children: [
                              if (currentState is LoadedChatScreenState)
                                ListView.separated(
                                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: currentStateModel.messages.length,
                                  itemBuilder: (context, index) {
                                    final message = currentStateModel.messages[index];
                                    return MessageWidget(
                                        message: message, currentUser: currentUser);
                                  },
                                )
                              else
                                const LoadingMessagesWidget()
                            ],
                          ),
                        ),
                        BottomChatWidget(
                          chatsBloc: _chatScreenBloc,
                        ),
                        if (currentStateModel.showEmojiPicker)
                          EmojiPickerHelper(
                            chatScreenBloc: _chatScreenBloc,
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
