import 'package:yahay/src/features/telegram_file_picker_feature/data/models/telegram_path_folder_file_model.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/mixins/app_storage_file_mixin/app_storage_file_mixin.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/mixins/recent_file_mixin/downloads_path_files.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/mixins/recent_file_mixin/recent_galley_file_mixin.dart';

class TelegramFilePickerRepoImpl
    with RecentGalleyFileMixin, DownloadsPathFiles, AppStorageFileMixin
    implements TelegramFilePickerRepo {
  @override
  Stream<TelegramPathFolderFileModel?> getRecentImagesAndVideos({
    RecentFilesOptions? options,
  }) => getAllImagesAndVideos(options: options);

  @override
  Stream<TelegramPathFolderFileModel?> getRecentFiles() =>
      downloadsPathFilesData();

  @override
  Stream<TelegramPathFolderFileModel?> getSpecificFolderData(String path) =>
      getSpecificFolderDataStream(path);
}
