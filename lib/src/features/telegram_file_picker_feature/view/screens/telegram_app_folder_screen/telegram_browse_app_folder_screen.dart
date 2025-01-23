import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_folder_enums.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';
import 'telegram_browse_folder_widget.dart';

class TelegramBrowseAppFolderScreen extends StatefulWidget {
  const TelegramBrowseAppFolderScreen({
    super.key,
  });

  @override
  State<TelegramBrowseAppFolderScreen> createState() => _TelegramBrowseAppFolderScreenState();
}

class _TelegramBrowseAppFolderScreenState extends State<TelegramBrowseAppFolderScreen>
    with FolderCreator {
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
            context.read<TelegramFilePickerBloc>().add(
                  const TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
                    TelegramFileFolderEnum.recentDownloadsScreen,
                  ),
                );
            Future.delayed(const Duration(milliseconds: 300), () {
              context
                  .read<TelegramFilePickerBloc>()
                  .add(const TelegramFilePickerEvents.clearSelectedGalleryFileEvent());
            });
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
                context.read<TelegramFilePickerBloc>().add(
                      const TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
                        TelegramFileFolderEnum.browseTheFolder,
                      ),
                    );

                final dir = "${(await getApplicationDir())?.path}/${foldersName[index]}";

                debugPrint("clicking path: $dir");
                // init here for folder data
                context.read<TelegramFilePickerBloc>().add(
                      TelegramFilePickerEvents.setSpecificFolderPathInOrderToGetDataFromThereEvent(
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
