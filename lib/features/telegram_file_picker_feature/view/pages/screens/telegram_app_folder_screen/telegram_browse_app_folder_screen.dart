import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_folder_enums.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/injections/injections.dart';

import 'telegram_browse_folder_widget.dart';

class TelegramBrowseAppFolderScreen extends StatefulWidget {
  const TelegramBrowseAppFolderScreen({super.key});

  @override
  State<TelegramBrowseAppFolderScreen> createState() => _TelegramBrowseAppFolderScreenState();
}

class _TelegramBrowseAppFolderScreenState extends State<TelegramBrowseAppFolderScreen>
    with FolderCreator {
  late final TelegramFilePickerBloc _telegramFilePickerBloc;

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
            _telegramFilePickerBloc.events.add(
              const SelectScreenForFilesPickerScreenEvent(
                TelegramFileFolderEnum.recentDownloadsScreen,
              ),
            );
          },
          title: "...",
        ),
        const SizedBox(height: 20),
        ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: foldersName.length,
          itemBuilder: (context, index) {
            return TelegramFolderWidget(
              onTap: () async {
                //
                _telegramFilePickerBloc.events.add(
                  const SelectScreenForFilesPickerScreenEvent(
                    TelegramFileFolderEnum.browseTheFolder,
                  ),
                );

                final dir = "${(await getApplicationDir())?.path}/${foldersName[index]}";

                debugPrint("clicking path: $dir");
                // init here for folder data
                _telegramFilePickerBloc.events.add(
                  SetSpecificFolderPathInOrderToGetDataFromThereEvent(
                    dir,
                  ),
                );
              },
              title: foldersName[index],
            );
          },
        ),
      ],
    );
  }
}
