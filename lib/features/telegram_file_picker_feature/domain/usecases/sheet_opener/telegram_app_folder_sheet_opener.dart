import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/screens/telegram_app_folder_screen/telegram_browse_app_folder_screen.dart';

abstract final class TelegramAppFolderSheetOpener {
  static Future<void> openSheet(BuildContext context) async {
    // await showModalBottomSheet(
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) {
    //     return const TelegramBrowseAppFolderScreen(telegramFilePickerBloc: null,);
    //   },
    // );
  }
}
