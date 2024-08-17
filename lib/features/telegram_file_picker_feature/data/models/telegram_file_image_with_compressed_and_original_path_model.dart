import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_with_compressed_and_original_path_entity.dart';

final class TelegramPathFolderFileModel extends TelegramPathFolderFile {
  TelegramPathFolderFileModel(
    super.file, {
    super.originalPath,
    super.isFolder,
    super.isImage,
    super.isVideo,
    super.fileExtension,
  });

  TelegramPathFolderFileModel? fromEntity(
    TelegramPathFolderFile? entity,
  ) {
    if (entity == null) return null;
    return TelegramPathFolderFileModel(
      entity.file,
      originalPath: entity.originalPath,
      isFolder: entity.isFolder,
      isImage: entity.isImage,
      isVideo: entity.isVideo,
      fileExtension: entity.fileExtension,
    );
  }
}
