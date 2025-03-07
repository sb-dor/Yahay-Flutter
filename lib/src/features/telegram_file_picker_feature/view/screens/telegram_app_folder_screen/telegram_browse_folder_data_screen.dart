import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/reusable_widgets/telegram_storage_file_widget.dart';
import 'telegram_browse_folder_widget.dart';

class TelegramBrowseFolderDataScreen extends StatefulWidget {
  final VoidCallback onBackFolder;

  const TelegramBrowseFolderDataScreen({super.key, required this.onBackFolder});

  @override
  State<TelegramBrowseFolderDataScreen> createState() =>
      _TelegramBrowseFolderDataScreenState();
}

class _TelegramBrowseFolderDataScreenState
    extends State<TelegramBrowseFolderDataScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        const SizedBox(height: 20),
        TelegramFolderWidget(onTap: widget.onBackFolder, title: "..."),
        const SizedBox(height: 20),
        BlocBuilder<TelegramFilePickerBloc, TelegramFilePickerStates>(
          builder: (context, state) {
            return TelegramStorageFileWidget(
              list:
                  state
                      .telegramFilePickerStateModel
                      .specificFolderFilesPagination,
            );
          },
        ),
      ],
    );
  }
}
