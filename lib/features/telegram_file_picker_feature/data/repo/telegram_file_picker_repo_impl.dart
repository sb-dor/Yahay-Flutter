import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_with_compressed_and_original_path_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_with_compressed_and_original_path_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/app_storage_file_mixin/app_storage_file_mixin.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/recent_file_mixin/downloads_path_files.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/recent_file_mixin/recent_file_mixin.dart';

class TelegramFilePickerRepoImpl
    with RecentFileMixin, DownloadsPathFiles, AppStorageFileMixin
    implements TelegramFilePickerRepo {
  @override
  Stream<TelegramFileImageWithCompressedAndOriginalPathModel?> getRecentImagesAndVideos() =>
      getAllImagesAndVideos();

  @override
  Stream<TelegramFileImageWithCompressedAndOriginalPathModel?> getRecentFiles() =>
      downloadsPathFilesData();

  @override
  Stream<TelegramFileImageWithCompressedAndOriginalPathEntity?> getSpecificFolderData(
    String path,
  ) =>
      getSpecificFolderDataStream(path);
}
