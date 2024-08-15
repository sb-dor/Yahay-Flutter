import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/injections/injections.dart';

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
        _TelegramFolderWidget(
          onTap: () {
            _telegramFilePickerBloc.events.add(const SelectScreenForFilesPickerScreenEvent(0));
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
            return _TelegramFolderWidget(
              onTap: () {},
              title: foldersName[index],
            );
          },
        ),
      ],
    );
  }
}

class _TelegramFolderWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const _TelegramFolderWidget({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Icon(Icons.folder),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      "Folder",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
