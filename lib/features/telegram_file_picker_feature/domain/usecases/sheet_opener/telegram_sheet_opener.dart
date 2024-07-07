import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/telegram_draggable_scrollable_bottom_sheet.dart';

abstract class TelegramSheetOpener {
  static Future<void> telegramSheetOpener(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const TelegramDraggableScrollableBottomSheet();
      },
    );
  }
}
