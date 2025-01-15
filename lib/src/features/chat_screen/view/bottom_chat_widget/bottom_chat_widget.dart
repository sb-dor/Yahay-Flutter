import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yahay/src/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/src/features/chat_screen/view/bloc/chat_screen_events.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/usecases/sheet_opener/telegram_sheet_opener.dart';

class BottomChatWidget extends StatefulWidget {
  final ChatScreenBloc chatsBloc;

  const BottomChatWidget({
    super.key,
    required this.chatsBloc,
  });

  @override
  State<BottomChatWidget> createState() => _BottomChatWidgetState();
}

class _BottomChatWidgetState extends State<BottomChatWidget> {
  late ChatScreenBloc _chatsBloc;
  final FocusNode _focusNode = FocusNode();
  bool permissionForFilePicking = true;

  @override
  void initState() {
    super.initState();
    _chatsBloc = widget.chatsBloc;
  }

  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 35),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _chatsBloc.states.value.chatScreenStateModel.messageController,
                        textInputAction: TextInputAction.newline,
                        onTap: () {
                          _chatsBloc.events.add(ChangeEmojiPicker(value: false));
                        },
                        focusNode: _focusNode,
                        onTapOutside: (v) {
                          _chatsBloc.events.add(ChangeEmojiPicker(value: false));
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onChanged: (v) {
                          if (v.isEmpty) {
                            permissionForFilePicking = true;
                          } else {
                            permissionForFilePicking = false;
                          }
                          setState(() {});
                        },
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
                  duration: const Duration(milliseconds: 350),
                  bottom: -1,
                  right: permissionForFilePicking ? 40 : 0,
                  child: IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _chatsBloc.events.add(ChangeEmojiPicker());
                    },
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: _chatsBloc.states.value.chatScreenStateModel.showEmojiPicker
                          ? Colors.blue
                          : null,
                    ),
                  ),
                ),
                if (permissionForFilePicking)
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    bottom: -1,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        TelegramSheetOpener.telegramSheetOpener(context);
                      },
                      icon: const FaIcon(FontAwesomeIcons.paste),
                    ),
                  )
              ],
            ),
          ),
          IconButton(
            onPressed: () => _chatsBloc.events.add(SendMessageEvent()),
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
