import 'package:flutter/material.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_folder_enums.dart';

class TelegramStorageFilePickerDataModel {
  final Color iconBackgroundColor;
  final Widget icon;
  final String title;
  final String content;
  final VoidCallback onTap;

  TelegramStorageFilePickerDataModel({
    required this.iconBackgroundColor,
    required this.icon,
    required this.title,
    required this.content,
    required this.onTap,
  });

  static List<TelegramStorageFilePickerDataModel> data(
    TelegramFilePickerBloc telegramFilerPickerBloc,
  ) => [
    TelegramStorageFilePickerDataModel(
      iconBackgroundColor: Colors.green,
      icon: const Icon(Icons.storage, color: Colors.white, size: 30),
      title: "Internal Storage",
      content: "Browse your file system",
      onTap: () {
        telegramFilerPickerBloc.add(
          const TelegramFilePickerEvents.browseInternalStorageAndSelectFilesEvent(),
        );
      },
    ),
    TelegramStorageFilePickerDataModel(
      iconBackgroundColor: Colors.blue,
      icon: const Icon(Icons.folder, color: Colors.white, size: 30),
      title: "Yahay",
      content: "Browse the app's folder",
      onTap: () async {
        telegramFilerPickerBloc.add(
          const TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
            TelegramFileFolderEnum.browseTheAppsFolder,
          ),
        );
      },
    ),
    TelegramStorageFilePickerDataModel(
      iconBackgroundColor: Colors.amber,
      icon: const Icon(Icons.folder, color: Colors.white, size: 30),
      title: "Gallery",
      content: "To send images without compression",
      onTap: () async {
        telegramFilerPickerBloc.add(
          const TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
            TelegramFileFolderEnum.browseTheGalleryFolder,
          ),
        );

        Future.delayed(const Duration(milliseconds: 300), () {
          telegramFilerPickerBloc.add(
            const TelegramFilePickerEvents.getSpecificFolderDataEvent(
              getGalleryData: true,
            ),
          );
        });
      },
    ),
  ];
}
