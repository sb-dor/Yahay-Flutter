import 'package:flutter/material.dart';

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
