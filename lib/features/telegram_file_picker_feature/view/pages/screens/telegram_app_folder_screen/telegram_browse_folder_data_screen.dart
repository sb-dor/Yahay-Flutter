import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/screens/telegram_app_folder_screen/telegram_browse_folder_widget.dart';
import 'package:yahay/injections/injections.dart';

class TelegramBrowseFolderDataScreen extends StatefulWidget {
  const TelegramBrowseFolderDataScreen({super.key});

  @override
  State<TelegramBrowseFolderDataScreen> createState() => _TelegramBrowseFolderDataScreenState();
}

class _TelegramBrowseFolderDataScreenState extends State<TelegramBrowseFolderDataScreen> {
  late TelegramFilePickerBloc _telegramFilePickerBloc;

  @override
  void initState() {
    super.initState();
    _telegramFilePickerBloc = snoopy<TelegramFilePickerBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        const SizedBox(height: 20),
        TelegramFolderWidget(
          onTap: () {
            _telegramFilePickerBloc.events.add(const SelectScreenForFilesPickerScreenEvent(0));
          },
          title: "...",
        ),
      ],
    );
  }
}
