import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_states.dart';
import 'package:yahay/injections/injections.dart';

class BottomChatWidget extends StatefulWidget {
  const BottomChatWidget({super.key});

  @override
  State<BottomChatWidget> createState() => _BottomChatWidgetState();
}

class _BottomChatWidgetState extends State<BottomChatWidget> {
  late ChatScreenBloc _chatsBloc;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _chatsBloc = snoopy<ChatScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatScreenStates>(
      stream: _chatsBloc.states,
      builder: (context, state) {
        switch (state.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const LinearProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:
            final currentState = state.requireData;
            final currentStateModel = currentState.chatScreenStateModel;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GestureDetector(
                            onTap: () => _focusNode.requestFocus(),
                            child: Container(
                              constraints: const BoxConstraints(
                                maxHeight: 100,
                              ),
                              color: Theme.of(context).inputDecorationTheme.fillColor,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 35),
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                controller: currentStateModel.messageController,
                                textInputAction: TextInputAction.send,
                                focusNode: _focusNode,
                                onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  isDense: true,
                                  hintText: "Message",
                                  contentPadding: EdgeInsets.all(0),
                                ),
                                maxLines: null,
                              ),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(seconds: 1),
                          bottom: -1,
                          right: 0,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => [],
                                icon: const Icon(
                                  Icons.emoji_emotions_outlined,
                                ),
                              ),
                              IconButton(
                                onPressed: () => [],
                                icon: const FaIcon(FontAwesomeIcons.fileClipboard),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => [],
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            );
        }
      },
    );
  }
}
