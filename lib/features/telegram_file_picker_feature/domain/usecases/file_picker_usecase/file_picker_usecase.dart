
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_with_compressed_and_original_path_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';

class FilePickerUseCase {
  final TelegramFilePickerRepo _filePickerRepo;

  FilePickerUseCase(this._filePickerRepo);

  //
  Stream<TelegramPathFolderFile?> getRecentImagesAndVideos() async* {
    yield* _filePickerRepo.getRecentImagesAndVideos();
  }

  //
  Stream<TelegramPathFolderFile?> downloadsPathFilesData() async* {
    yield* _filePickerRepo.getRecentFiles();
  }
}
