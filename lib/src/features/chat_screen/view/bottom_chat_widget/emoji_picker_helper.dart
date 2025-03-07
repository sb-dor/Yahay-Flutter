import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:provider/provider.dart';
import 'package:yahay/src/features/chat_screen/bloc/chat_screen_bloc.dart';

class EmojiPickerHelper extends StatefulWidget {
  final TextEditingController messageController;

  const EmojiPickerHelper({super.key, required this.messageController});

  @override
  State<EmojiPickerHelper> createState() => _EmojiPickerHelperState();
}

class _EmojiPickerHelperState extends State<EmojiPickerHelper> {
  late final ChatScreenBloc _chatScreenBloc;

  @override
  void initState() {
    super.initState();
    _chatScreenBloc = Provider.of<ChatScreenBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onEmojiSelected: (Category? category, Emoji emoji) {
        // Do something when emoji is tapped (optional)
      },
      onBackspacePressed: () {
        // Do something when the user taps the backspace button (optional)
        // Set it to null to hide the Backspace-Button
        _chatScreenBloc.add(
          const ChatScreenEvents.changeEmojiPicker(value: false),
        );
      },
      textEditingController: widget.messageController,
      // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
      config: Config(
        height: 250,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax:
              28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.20
                  : 1.0),
        ),
        // viewOrderConfig: ViewOrderConfig(
        //   bottom: EmojiPickerItem.categoryBar,
        // ),
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: const CategoryViewConfig(),
        bottomActionBarConfig: const BottomActionBarConfig(
          enabled: false,
          backgroundColor: Colors.white,
          buttonColor: Colors.white,
          buttonIconColor: Colors.grey,
        ),
        searchViewConfig: const SearchViewConfig(backgroundColor: Colors.white),
      ),
    );
  }
}
