import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';

class TelegramBrowseAppFolderScreen extends StatefulWidget {
  const TelegramBrowseAppFolderScreen({super.key});

  @override
  State<TelegramBrowseAppFolderScreen> createState() => _TelegramBrowseAppFolderScreenState();
}

class _TelegramBrowseAppFolderScreenState extends State<TelegramBrowseAppFolderScreen>
    with FolderCreator {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.96,
      expand: false,
      builder: (context, controller) {
        return ListView(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 20),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foldersName.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
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
                              Text("${foldersName[index]}"),
                              Text(
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
                );
              },
            ),
          ],
        );
      },
    );
  }
}
