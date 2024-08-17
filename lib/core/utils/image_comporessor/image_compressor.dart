import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_path_folder_file_model.dart';

abstract final class ImageCompressor {
  static Future<TelegramPathFolderFileModel?> compressedImageFile({
    required File file,
    required String? directoryPath,
    int quality = 60,
    CompressFormat format = CompressFormat.jpeg,
  }) async {
    String imagePath = '$directoryPath/${basenameWithoutExtension(file.path)}_temp.${format.name}';

    final XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
      file.path,
      imagePath,
      quality: quality,
      format: format,
    );

    if (compressedImage == null) {
      throw ("Failed to compress the image");
    }
    final result = TelegramPathFolderFileModel(
      File(compressedImage.path),
      originalPath: file.path,
      isImage: true,
    );

    return result;
  }
}
