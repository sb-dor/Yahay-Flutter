import 'dart:io';

import 'package:yahay/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/recent_file_mixin/recent_file_mixin.dart';

class TelegramFilePickerRepoImpl with RecentFileMixin implements TelegramFilePickerRepo {
  @override
  Stream<File?> getRecentFiles() async* {
    // from mixin class
    yield* getAllImagesAndVideos();
  }
}
