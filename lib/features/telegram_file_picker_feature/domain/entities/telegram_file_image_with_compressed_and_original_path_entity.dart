import 'dart:io';

base class TelegramPathFolderFile {
  final File file;
  final String? originalPath;
  final bool isFolder;
  final bool isImage;
  final bool isVideo;
  final String? fileExtension;

  TelegramPathFolderFile(
    this.file, {
    this.originalPath,
    this.isFolder = false,
    this.isImage = false,
    this.isVideo = false,
    this.fileExtension,
  });
}
