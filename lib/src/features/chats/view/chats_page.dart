import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/core/global_usages/widgets/search_widget/search_widget.dart';
import 'package:yahay/src/features/chats/bloc/chats_bloc.dart';
import 'package:yahay/src/features/chats/bloc/chats_events.dart';
import 'package:yahay/src/features/chats/bloc/chats_states.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';

import 'chat_widget/chat_loading_widget.dart';
import 'chat_widget/chat_widget.dart';
import 'chats_appbar/chats_appbar.dart';

@RoutePage()
class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  ChatsBloc? _chatsBloc;

  @override
  void initState() {
    super.initState();
    _chatsBloc = DependenciesScope.of(context, listen: false).chatsBloc;
    if (_chatsBloc != null) {
      _chatsBloc?.events.add(GetUserChatsEvent());
      _chatsBloc?.events.add(ChatListenerInitEvent(_chatsBloc!.events));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatsStates>(
      stream: _chatsBloc?.states,
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const SizedBox();
          case ConnectionState.active:
          case ConnectionState.done:
            final currentState = snap.requireData;
            final currentStateModel = currentState.chatsStateModel;
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
                child: const ChatsAppbar(),
              ),
              body: RefreshIndicator(
                onRefresh: () async => _chatsBloc?.events.add(GetUserChatsEvent(refresh: true)),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  children: [
                    SearchWidget(
                      value: (String value) {},
                      onDispose: () {},
                    ),
                    if (currentState is LoadedChatsState)
                      ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentStateModel.chats.length,
                        itemBuilder: (context, index) {
                          final chat = currentStateModel.chats[index];
                          return ChatWidget(chat: chat);
                        },
                      )
                    else
                      const ChatLoadingWidget(),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
