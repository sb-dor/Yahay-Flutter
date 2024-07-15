import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:yahay/core/utils/permissions/permissions_service.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/recent_file_mixin/recent_file_mixin.dart';
import 'package:yahay/injections/injections.dart';

class FilePickerUseCase {
  final TelegramFilePickerRepo _filePickerRepo;

  FilePickerUseCase(this._filePickerRepo);

  //
  Stream<File?> getAllImagesAndVideos() async* {
    yield* _filePickerRepo.getRecentFiles();
  }
}
