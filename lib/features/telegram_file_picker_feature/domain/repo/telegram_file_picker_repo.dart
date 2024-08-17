import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_path_folder_file.dart';

// means that other classes can't "extend" it
// classes only can "implement"
abstract interface class TelegramFilePickerRepo {
  // for getting recent files -> images and videos
  Stream<TelegramPathFolderFile?> getRecentImagesAndVideos();

  // for getting all download's path files here
  Stream<TelegramPathFolderFile?> getRecentFiles();

  // for getting specific app folder data, does not matter what
  Stream<TelegramPathFolderFile?> getSpecificFolderData(String path);
}
