import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_with_compressed_and_original_path_entity.dart';

@immutable
abstract base class TelegramFilePickerEvents {
  const TelegramFilePickerEvents();
}

@immutable
final class JustEmitStateEvent extends TelegramFilePickerEvents {
  const JustEmitStateEvent();
}

//
@immutable
final class InitAllPicturesEvent extends TelegramFilePickerEvents {
  final bool clearAll;
  final DraggableScrollableController? controller;

  const InitAllPicturesEvent(
    this.clearAll, {
    this.controller,
  });
}

@immutable
final class ChangeStateToAllPicturesEvent extends TelegramFilePickerEvents {
  const ChangeStateToAllPicturesEvent();
}

@immutable
final class InitAllFilesEvent extends TelegramFilePickerEvents {
  final bool initFilePickerState;

  const InitAllFilesEvent({this.initFilePickerState = true});
}

@immutable
final class ChangeStateToAllFilesState extends TelegramFilePickerEvents {
  const ChangeStateToAllFilesState();
}

@immutable
final class InitAllMusicsEvent extends TelegramFilePickerEvents {
  const InitAllMusicsEvent();
}

@immutable
final class OpenHideBottomTelegramButtonEvent extends TelegramFilePickerEvents {
  final bool value;

  const OpenHideBottomTelegramButtonEvent(this.value);
}

//
// gallery section's functions
@immutable
final class ClosePopupEvent extends TelegramFilePickerEvents {
  const ClosePopupEvent();
}

@immutable
final class FileStreamHandlerEvent extends TelegramFilePickerEvents {
  final TelegramFileImageWithCompressedAndOriginalPathEntity? file;

  const FileStreamHandlerEvent(this.file);
}

@immutable
final class RecentFileStreamHandlerEvent extends TelegramFilePickerEvents {
  final TelegramFileImageWithCompressedAndOriginalPathEntity? file;

  const RecentFileStreamHandlerEvent(this.file);
}

@immutable
final class ImagesAndVideoPaginationEvent extends TelegramFilePickerEvents {
  const ImagesAndVideoPaginationEvent();
}

@immutable
final class SelectGalleryFileEvent extends TelegramFilePickerEvents {
  final TelegramFileImageEntity? telegramFileImageEntity;

  const SelectGalleryFileEvent(this.telegramFileImageEntity);
}

@immutable
final class RecentFilesPaginationEvent extends TelegramFilePickerEvents {
  const RecentFilesPaginationEvent();
}

//
final class BrowseInternalStorageAndSelectFilesEvent extends TelegramFilePickerEvents {
  const BrowseInternalStorageAndSelectFilesEvent();
}

final class SelectScreenForFilesPickerScreenEvent extends TelegramFilePickerEvents {
  final int screen;

  const SelectScreenForFilesPickerScreenEvent(this.screen);
}
