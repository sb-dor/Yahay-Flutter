import 'dart:io';

base class TelegramPathFolderFile {
  final File file;
  String? originalPath;
  bool isFolder;
  bool isImage;
  bool isVideo;
  String? fileExtension;
  String? fileName;

  TelegramPathFolderFile(
    this.file, {
    this.originalPath,
    this.isFolder = false,
    this.isImage = false,
    this.isVideo = false,
    this.fileExtension,
    this.fileName,
  });
}
