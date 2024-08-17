import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_path_folder_file.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';

class FilePickerUseCase {
  final TelegramFilePickerRepo _filePickerRepo;

  FilePickerUseCase(this._filePickerRepo);

  // for getting recent files -> images and videos
  Stream<TelegramPathFolderFile?> getRecentImagesAndVideos() async* {
    yield* _filePickerRepo.getRecentImagesAndVideos();
  }

  // for getting all download's path files here
  Stream<TelegramPathFolderFile?> downloadsPathFilesData() async* {
    yield* _filePickerRepo.getRecentFiles();
  }

  //
  // for getting specific app folder data, does not matter what
  Stream<TelegramPathFolderFile?> getSpecificFolderData(String path) =>
      _filePickerRepo.getSpecificFolderData(path);
}
