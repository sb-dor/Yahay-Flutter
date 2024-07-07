import 'package:flutter/foundation.dart';

import 'state_model/telegram_file_picker_state_model.dart';

@immutable
abstract class TelegramFilePickerStates {
  final TelegramFilePickerStateModel telegramFilePickerStateModel;

  const TelegramFilePickerStates(this.telegramFilePickerStateModel);
}

class GalleryFilePickerState extends TelegramFilePickerStates {
  const GalleryFilePickerState(super.telegramFilePickerStateModel);
}
