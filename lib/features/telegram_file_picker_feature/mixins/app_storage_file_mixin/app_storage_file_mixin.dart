import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/core/utils/image_comporessor/image_compressor.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_with_compressed_and_original_path_model.dart';
import 'package:yahay/injections/injections.dart';
import 'package:path/path.dart' as p;

mixin class AppStorageFileMixin {
  //
  Stream<TelegramPathFolderFileModel?> getSpecificFolderDataStream(
    String path,
  ) async* {
    //

    final ReceivePort mainPort = ReceivePort();

    final rootIsolateToken = RootIsolateToken.instance!;

    Isolate.spawn(_isolateHelper, [
      rootIsolateToken,
      mainPort.sendPort,
      path,
    ]);

    await for (final each in mainPort) {
      if (each is TelegramPathFolderFileModel) {
        yield each;
      } else if (each is String && each == Constants.killIsolate) {
        mainPort.close();
        break;
      }
    }
  }

  //
  static Future<void> _isolateHelper(List<dynamic> args) async {
    RootIsolateToken mainRootIsolateToken = args[0] as RootIsolateToken;

    BackgroundIsolateBinaryMessenger.ensureInitialized(mainRootIsolateToken);

    SendPort sendPort = args[1] as SendPort;

    String path = args[2] as String;

    final directory = Directory(path);

    if (!directory.existsSync()) {
      sendPort.send(Constants.killIsolate);
      return;
    }

    final reusables = snoopy<ReusableGlobalFunctions>();

    final tempPath = await getTemporaryDirectory();

    final data = directory.listSync();

    for (final each in data) {
      if (each.existsSync()) {
        File file = File(each.path);

        if (FileSystemEntity.isDirectorySync(each.path)) {
          final folder = TelegramPathFolderFileModel(
            file,
            isFolder: true,
          );
          sendPort.send(folder);
        } else if (reusables.isImageFile(each.path)) {
          final compressedImage = await ImageCompressor.compressedImageFile(
            file: file,
            directoryPath: tempPath.path,
          );
          sendPort.send(compressedImage);
          return;
        } else if (reusables.isVideoFile(each.path)) {
          final video = TelegramPathFolderFileModel(
            file,
            isVideo: true,
          );
          sendPort.send(video);
        } else {
          final otherFile = TelegramPathFolderFileModel(
            file,
            fileExtension: p.extension(each.path),
          );
          sendPort.send(otherFile);
        }
      }
    }

    sendPort.send(Constants.killIsolate);
  }
//
}
