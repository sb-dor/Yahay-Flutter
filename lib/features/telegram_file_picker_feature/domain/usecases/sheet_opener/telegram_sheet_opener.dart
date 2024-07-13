import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/telegram_draggable_scrollable_bottom_sheet.dart';
import 'package:yahay/injections/injections.dart';

abstract class TelegramSheetOpener {
  static Future<List<TelegramFileImageEntity?>> telegramSheetOpener(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const TelegramDraggableScrollableBottomSheet();
      },
    );
    final bloc = snoopy<TelegramFilePickerBloc>().states.value.telegramFilePickerStateModel;
    return bloc.clonedPickedFiles;
  }
}
