import 'dart:io';

// means that other classes can't "extend" it
// classes only can "implement"
abstract interface class TelegramFilePickerRepo {
  // for getting recent files -> images and videos
  Stream<File?> getRecentImagesAndVideos();

  // for getting all download's path files here
  Stream<File?> getRecentFiles();
}
