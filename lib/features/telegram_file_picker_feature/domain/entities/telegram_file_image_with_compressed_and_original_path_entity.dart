import 'dart:io';

base class TelegramFileImageWithCompressedAndOriginalPathEntity {
  final File file;
  final String? originalPath;

  TelegramFileImageWithCompressedAndOriginalPathEntity(
    this.file, {
    this.originalPath,
  });
}
