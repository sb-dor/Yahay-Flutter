import 'dart:io';

import 'package:yahay/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';

class FilePickerUseCase {
  final TelegramFilePickerRepo _filePickerRepo;

  FilePickerUseCase(this._filePickerRepo);

  //
  Stream<File?> getRecentImagesAndVideos() async* {
    yield* _filePickerRepo.getRecentImagesAndVideos();
  }

  //
  Stream<File?> downloadsPathFilesData() async* {
    yield* _filePickerRepo.getRecentFiles();
  }
}
