import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_path_folder_file.dart';

final class TelegramPathFolderFileModel extends TelegramPathFolderFile {
  TelegramPathFolderFileModel(
    super.file, {
    super.originalPath,
    super.isFolder,
    super.isImage,
    super.isVideo,
    super.fileExtension,
    super.fileName,
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
      fileName: entity.fileName,
    );
  }
}
