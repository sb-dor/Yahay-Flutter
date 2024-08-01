import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_with_compressed_and_original_path_entity.dart';

final class TelegramFileImageWithCompressedAndOriginalPathModel
    extends TelegramFileImageWithCompressedAndOriginalPathEntity {
  TelegramFileImageWithCompressedAndOriginalPathModel(
    super.file, {
    super.originalPath,
  });

  TelegramFileImageWithCompressedAndOriginalPathModel? fromEntity(
    TelegramFileImageWithCompressedAndOriginalPathEntity? entity,
  ) {
    if (entity == null) return null;
    return TelegramFileImageWithCompressedAndOriginalPathModel(
      file,
      originalPath: originalPath,
    );
  }
}
