import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/data_models/telegram_file_picker_bottom_button.dart';

class TelegramBottomPickerButton extends StatelessWidget {
  const TelegramBottomPickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Theme.of(context).cardColor, //Theme.of(context).cardColor
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 10, right: 10),
        separatorBuilder: (context, index) => const SizedBox(width: 40),
        scrollDirection: Axis.horizontal,
        itemCount: TelegramFilePickerBottomButton.listOfBottomButtons.length,
        itemBuilder: (context, index) {
          final item = TelegramFilePickerBottomButton.listOfBottomButtons[index];
          return item.icon;
        },
      ),
    );
  }
}
