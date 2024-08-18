import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_folder_enums.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/injections/injections.dart';

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

  static final _telegramBloc = snoopy<TelegramFilePickerBloc>();

  static final List<TelegramStorageFilePickerDataModel> data = [
    TelegramStorageFilePickerDataModel(
      iconBackgroundColor: Colors.green,
      icon: const Icon(
        Icons.storage,
        color: Colors.white,
        size: 30,
      ),
      title: "Internal Storage",
      content: "Browse your file system",
      onTap: () {
        _telegramBloc.events.add(const BrowseInternalStorageAndSelectFilesEvent());
      },
    ),
    TelegramStorageFilePickerDataModel(
      iconBackgroundColor: Colors.blue,
      icon: const Icon(
        Icons.folder,
        color: Colors.white,
        size: 30,
      ),
      title: "Yahay",
      content: "Browse the app's folder",
      onTap: () async {
        _telegramBloc.events.add(
          const SelectScreenForFilesPickerScreenEvent(
            TelegramFileFolderEnum.browseTheAppsFolder,
          ),
        );
      },
    ),
    TelegramStorageFilePickerDataModel(
      iconBackgroundColor: Colors.amber,
      icon: const Icon(
        Icons.folder,
        color: Colors.white,
        size: 30,
      ),
      title: "Gallery",
      content: "To send images without compression",
      onTap: () async {
        _telegramBloc.events.add(
          const SelectScreenForFilesPickerScreenEvent(
            TelegramFileFolderEnum.browseTheGalleryFolder,
          ),
        );

        _telegramBloc.events.add(
          const GetSpecificFolderDataEvent(
            getGalleryData: true,
          ),
        );
      },
    ),
  ];
}
