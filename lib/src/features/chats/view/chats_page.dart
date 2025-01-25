import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/core/global_usages/widgets/search_widget/search_widget.dart';
import 'package:yahay/src/features/chats/bloc/chats_bloc.dart';
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
  late final ChatsBloc? _chatsBloc;

  @override
  void initState() {
    super.initState();
    _chatsBloc = DependenciesScope.of(context, listen: false).chatsBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        child: const ChatsAppbar(),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _chatsBloc?.add(const ChatsEvents.getUserChatsEvent(refresh: true)),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          children: [
            SearchWidget(
              value: (String value) {},
              onDispose: () {},
            ),
            BlocBuilder<ChatsBloc, ChatsStates>(
              bloc: _chatsBloc,
              builder: (context, state) {
                switch (state) {
                  case InitialChatsState():
                    return const SizedBox.shrink();
                  case LoadingChatsState():
                    return const ChatLoadingWidget();
                  case ErrorChatsState():
                    return const Text(Constants.somethingWentWrong);
                  case LoadedChatsState():
                    final currentStateModel = state.chatsStateModel;
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 15),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentStateModel.chats.length,
                      itemBuilder: (context, index) {
                        final chat = currentStateModel.chats[index];
                        return ChatWidget(chat: chat);
                      },
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
