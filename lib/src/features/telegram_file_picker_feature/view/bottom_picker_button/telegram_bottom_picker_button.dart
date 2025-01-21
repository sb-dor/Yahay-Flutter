import 'package:flutter/material.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/data/models/data_models/telegram_file_picker_bottom_button.dart';

class TelegramBottomPickerButton extends StatefulWidget {
  final TelegramFilePickerBloc _telegramFilePickerBloc;

  const TelegramBottomPickerButton({
    super.key,
    required TelegramFilePickerBloc telegramFilePickerBloc,
  }) : _telegramFilePickerBloc = telegramFilePickerBloc;

  @override
  State<TelegramBottomPickerButton> createState() => _TelegramBottomPickerButtonState();
}

class _TelegramBottomPickerButtonState extends State<TelegramBottomPickerButton> {
  late final List<TelegramFilePickerBottomButton> _buttons;

  @override
  void initState() {
    super.initState();
    _buttons = TelegramFilePickerBottomButton.listOfBottomButtons(widget._telegramFilePickerBloc);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Theme.of(context).cardColor, //Theme.of(context).cardColor
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 10, right: 10),
        separatorBuilder: (context, index) => const SizedBox(width: 40),
        scrollDirection: Axis.horizontal,
        itemCount: _buttons.length,
        itemBuilder: (context, index) {
          final item = _buttons[index];
          return item.icon;
        },
      ),
    );
  }
}
