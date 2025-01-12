import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/telegram_draggable_scrollable_bottom_sheet.dart';

abstract class TelegramSheetOpener {
  static Future<List<TelegramFileImageEntity?>> telegramSheetOpener(BuildContext context) async {
    final List<TelegramFileImageEntity?> items = [];
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return TelegramDraggableScrollableBottomSheet(
          selectedItems: (List<TelegramFileImageEntity?> value) {
            items.addAll(value);
          },
        );
      },
    );
    return items;
  }
}
