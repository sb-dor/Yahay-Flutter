import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';

import 'widgets/telegram_files_from_storages_widget.dart';
import 'widgets/telegram_resent_files_from_storage_widget.dart';

class TelegramFilesPickerScreen extends StatelessWidget {
  final TelegramFilePickerBloc telegramFilePickerBloc;
  final ScrollController parentScrollController;

  const TelegramFilesPickerScreen({
    super.key,
    required this.telegramFilePickerBloc,
    required this.parentScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: parentScrollController,
      children: [
        const TelegramFilesFromStoragesWidget(),
        const SizedBox(height: 15),
        TelegramResentFilesFromStorageWidget(
          telegramFilePickerBloc: telegramFilePickerBloc,
        ),
      ],
    );
  }
}
