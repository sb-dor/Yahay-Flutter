import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';

@immutable
abstract class TelegramFilePickerEvents {
  const TelegramFilePickerEvents();
}

@immutable
class JustEmitStateEvent extends TelegramFilePickerEvents {
  const JustEmitStateEvent();
}

//
@immutable
class InitAllPicturesEvent extends TelegramFilePickerEvents {
  final bool clearAll;

  const InitAllPicturesEvent(this.clearAll);
}

@immutable
class InitAllFilesEvent extends TelegramFilePickerEvents {
  const InitAllFilesEvent();
}

@immutable
class InitAllMusicsEvent extends TelegramFilePickerEvents {
  const InitAllMusicsEvent();
}

@immutable
class OpenHideBottomTelegramButtonEvent extends TelegramFilePickerEvents {
  final bool value;

  const OpenHideBottomTelegramButtonEvent(this.value);
}

//
// gallery section's functions
@immutable
class ClosePopupEvent extends TelegramFilePickerEvents {
  const ClosePopupEvent();
}

@immutable
class FileStreamHandlerEvent extends TelegramFilePickerEvents {
  final File? file;

  const FileStreamHandlerEvent(this.file);
}

@immutable
class RecentFileStreamHandlerEvent extends TelegramFilePickerEvents {
  final File? file;

  const RecentFileStreamHandlerEvent(this.file);
}

@immutable
class ImagesAndVideoPaginationEvent extends TelegramFilePickerEvents {
  const ImagesAndVideoPaginationEvent();
}

@immutable
class SelectGalleryFileEvent extends TelegramFilePickerEvents {
  final TelegramFileImageEntity? telegramFileImageEntity;

  const SelectGalleryFileEvent(this.telegramFileImageEntity);
}
