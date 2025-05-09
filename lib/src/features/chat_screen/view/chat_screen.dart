import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/ui_kit/shimmer_loader.dart';
import 'package:yahay/src/features/chat_screen/bloc/chat_screen_bloc.dart';
import 'package:yahay/src/features/chat_screen/bloc/state_model/chat_screen_state_model.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/chat_screen_bloc_factory.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'app_bar/chat_screen_app_bar.dart';
import 'bottom_chat_widget/bottom_chat_widget.dart';
import 'bottom_chat_widget/emoji_picker_helper.dart';
import 'message_widget/loading_messages_widget.dart';
import 'message_widget/message_widget.dart';

@RoutePage()
class ChatScreen extends StatelessWidget {
  final ChatModel? chat;
  final UserModel? user; // temp for creating temp chat if chat does not exist

  const ChatScreen({super.key, required this.chat, required this.user});

  @override
  Widget build(BuildContext context) {
    final dependencyContainer = DependenciesScope.of(context, listen: false);
    return BlocProvider<ChatScreenBloc>(
      create:
          (context) =>
              ChatScreenBlocFactory(
                user: dependencyContainer.authBloc.state.authStateModel.user,
                channelsOptions: dependencyContainer.pusherClientService.options,
                restClientBase: dependencyContainer.restClientBase,
                logger: dependencyContainer.logger,
              ).create(),
      child: _ChatScreenUI(chat: chat, user: user),
    );
  }
}

class _ChatScreenUI extends StatefulWidget {
  final ChatModel? chat;
  final UserModel? user; // temp for creating temp chat if chat does not exist

  const _ChatScreenUI({required this.chat, required this.user});

  @override
  State<_ChatScreenUI> createState() => _ChatScreenUIState();
}

class _ChatScreenUIState extends State<_ChatScreenUI> {
  late final ChatScreenBloc _chatScreenBloc;
  late final AppThemeBloc _appThemeBloc;
  late UserModel? currentUser;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final dependencyContainer = DependenciesScope.of(context, listen: false);
    currentUser = dependencyContainer.authBloc.state.authStateModel.user;

    _chatScreenBloc = BlocProvider.of<ChatScreenBloc>(context, listen: false);
    _appThemeBloc = dependencyContainer.appThemeBloc;
    //
    //
    _chatScreenBloc.add(ChatScreenEvents.initChatScreenEvent(chat: widget.chat, user: widget.user));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _emojiClearHelper(ChatScreenStateModel currentStateModel) {
    if (currentStateModel.showEmojiPicker) {
      _chatScreenBloc.add(const ChatScreenEvents.changeEmojiPicker(value: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatScreenBloc, ChatScreenStates>(
      bloc: Provider.of<ChatScreenBloc>(context, listen: false),
      builder: (context, state) {
        switch (state) {
          case ChatScreen$InitialState():
            return const SizedBox();
          case ChatScreen$InProgressState():
            return const LoadingMessagesWidget();
          case ErrorChatScreenState():
            return const Center(child: Text(Constants.somethingWentWrong));
          case ChatScreen$SuccessfulState():
            final currentStateModel = state.chatScreenStateModel;
            return PopScope(
              canPop: !currentStateModel.showEmojiPicker,
              onPopInvokedWithResult: (v, _) => _emojiClearHelper(currentStateModel),
              child: GestureDetector(
                onTap: () {
                  _emojiClearHelper(currentStateModel);
                },
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
                    child: ChatScreenAppBar(
                      themeData: _appThemeBloc.theme.value,
                      chat: widget.chat,
                    ),
                  ),
                  body: ShimmerLoader(
                    isLoading: state is ChatScreen$InProgressState,
                    mode: _appThemeBloc.theme.value,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            reverse: true,
                            children: [
                              ListView.separated(
                                separatorBuilder: (context, index) => const SizedBox(height: 10),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: currentStateModel.messages.length,
                                itemBuilder: (context, index) {
                                  final message = currentStateModel.messages[index];
                                  return MessageWidget(message: message, currentUser: currentUser);
                                },
                              ),
                            ],
                          ),
                        ),
                        BottomChatWidget(messageController: _messageController),
                        if (currentStateModel.showEmojiPicker)
                          EmojiPickerHelper(messageController: _messageController),
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
