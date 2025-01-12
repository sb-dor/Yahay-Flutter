import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_events.dart';

class EmojiPickerHelper extends StatelessWidget {
  final ChatScreenBloc chatScreenBloc;

  const EmojiPickerHelper({
    super.key,
    required this.chatScreenBloc,
  });

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onEmojiSelected: (Category? category, Emoji emoji) {
        // Do something when emoji is tapped (optional)
      },
      onBackspacePressed: () {
        // Do something when the user taps the backspace button (optional)
        // Set it to null to hide the Backspace-Button
        chatScreenBloc.events.add(ChangeEmojiPicker(value: false));
      },
      textEditingController: chatScreenBloc.states.value.chatScreenStateModel.messageController,
      // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
      config: Config(
        height: 250,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax: 28 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.20 : 1.0),
        ),
        viewOrderConfig: ViewOrderConfig(
          bottom: EmojiPickerItem.categoryBar,
        ),
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: const CategoryViewConfig(),
        bottomActionBarConfig: const BottomActionBarConfig(
          enabled: false,
          backgroundColor: Colors.white,
          buttonColor: Colors.white,
          buttonIconColor: Colors.grey,
        ),
        searchViewConfig: const SearchViewConfig(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
