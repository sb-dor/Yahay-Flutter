import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_with_compressed_and_original_path_entity.dart';

// means that other classes can't "extend" it
// classes only can "implement"
abstract interface class TelegramFilePickerRepo {
  // for getting recent files -> images and videos
  Stream<TelegramFileImageWithCompressedAndOriginalPathEntity?> getRecentImagesAndVideos();

  // for getting all download's path files here
  Stream<TelegramFileImageWithCompressedAndOriginalPathEntity?> getRecentFiles();

  // for getting specific app folder data, does not matter what
  Stream<TelegramFileImageWithCompressedAndOriginalPathEntity?> getSpecificFolderData(String path);
}
