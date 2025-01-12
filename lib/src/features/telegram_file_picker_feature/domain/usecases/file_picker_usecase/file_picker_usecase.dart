import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_path_folder_file.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';

class FilePickerUseCase {
  final TelegramFilePickerRepo _filePickerRepo;

  FilePickerUseCase(this._filePickerRepo);

  // for getting recent files -> images and videos
  Stream<TelegramPathFolderFile?> getRecentImagesAndVideos() =>
      _filePickerRepo.getRecentImagesAndVideos();

  // for getting all download's path files here
  Stream<TelegramPathFolderFile?> downloadsPathFilesData() => _filePickerRepo.getRecentFiles();

  //
  // for getting specific app folder data, does not matter what
  Stream<TelegramPathFolderFile?> getSpecificFolderData(String path) =>
      _filePickerRepo.getSpecificFolderData(path);
}
