import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/src/core/utils/image_comporessor/image_compressor.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/data/models/telegram_path_folder_file_model.dart';
import 'package:path/path.dart' as p;

mixin class AppStorageFileMixin {
  //
  Stream<TelegramPathFolderFileModel?> getSpecificFolderDataStream(
    String path,
  ) async* {
    //

    final ReceivePort mainPort = ReceivePort();

    final rootIsolateToken = RootIsolateToken.instance!;

    Isolate.spawn(_isolateHelper, [rootIsolateToken, mainPort.sendPort, path]);

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
    final RootIsolateToken mainRootIsolateToken = args[0] as RootIsolateToken;

    BackgroundIsolateBinaryMessenger.ensureInitialized(mainRootIsolateToken);

    final SendPort sendPort = args[1] as SendPort;

    final String path = args[2] as String;

    final directory = Directory(path);

    if (!directory.existsSync()) {
      sendPort.send(Constants.killIsolate);
      return;
    }

    final reusables = ReusableGlobalFunctions.instance;

    final tempPath = await getTemporaryDirectory();

    final data = directory.listSync();

    for (final each in data) {
      if (each.existsSync()) {
        TelegramPathFolderFileModel? model = TelegramPathFolderFileModel(
          File(each.path),
          fileExtension: p.extension(each.path),
          fileName: p.basename(each.path),
        );

        if (FileSystemEntity.isDirectorySync(each.path)) {
          model.isFolder = true;
        } else if (reusables.isImageFile(each.path)) {
          model = (await ImageCompressor.compressedImageFile(
            file: model.file,
            directoryPath: tempPath.path,
          ))?.clone(
            fileExtension: model.fileExtension,
            fileName: model.fileName,
          );
        } else if (reusables.isVideoFile(each.path)) {
          model.isVideo = true;
        }
        sendPort.send(model);
      }
    }

    sendPort.send(Constants.killIsolate);
  }

  //
}
