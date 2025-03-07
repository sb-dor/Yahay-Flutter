import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/src/core/utils/image_comporessor/image_compressor.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/data/models/telegram_path_folder_file_model.dart';

mixin class DownloadsPathFiles {
  // final _permissions = snoopy<PermissionsService>();

  // final _reusables = snoopy<ReusableGlobalFunctions>();

  Stream<TelegramPathFolderFileModel?> downloadsPathFilesData(
    //{
    // String dirType = DownloadDirectoryTypes.downloads,
    //}
  ) async* {
    try {
      // final externalStoragePermission = await _permissions.manageExternalStoragePermission();
      //
      // final storagePermission = await _permissions.storagePermission();
      //
      // if (!externalStoragePermission && !storagePermission) return;

      final Directory? downloadsDirectory = await getDownloadPath();

      // debugPrint("downloades dir: $downloadsDirectory");

      if (downloadsDirectory == null) return;

      final ReceivePort sendingPort = ReceivePort();

      final rootIsolateToken = RootIsolateToken.instance!;

      final sendingList = [
        sendingPort.sendPort,
        downloadsDirectory.path,
        rootIsolateToken,
      ];

      debugPrint("sending list length is: $sendingList");

      Isolate.spawn(_fileFinder, sendingList);

      await for (final each in sendingPort) {
        if (each is TelegramPathFolderFileModel) {
          yield each;
        } else if (each is String && each == Constants.killIsolate) {
          sendingPort.close();
          break; // null indicates the end of the processing
        }
      }

      //
    } catch (e) {
      debugPrint("downloadsPathFilesData error is: $e");
    }
  }

  static Future<void> _fileFinder(List<dynamic> args) async {
    final SendPort receivingPort = args[0];
    final Directory directory = Directory(args[1]);
    final rootIsolateToken = args[2] as RootIsolateToken;

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    // final defaultCacheManager = DefaultCacheManager();

    final reusables = ReusableGlobalFunctions.instance;

    final directoryPath = await getTemporaryDirectory();
    await for (final entity in directory.list(
      recursive: false,
      followLinks: false,
    )) {
      if (FileSystemEntity.isDirectorySync(entity.path)) {
        await _fileFinder([receivingPort, entity.path, rootIsolateToken]);
      }
      if (FileSystemEntity.isFileSync(entity.path)) {
        final file = File(entity.path);
        if (reusables.isImageFile(file.path)) {
          // final fileBytes = await file.readAsBytes();
          // await defaultCacheManager.putFile(
          //   file.path,
          //   fileBytes,
          //   maxAge: const Duration(days: 1),
          // );
          final compressedFile = await ImageCompressor.compressedImageFile(
            file: file,
            directoryPath: directoryPath.path,
          );
          receivingPort.send(compressedFile);
        }
      }
    }

    receivingPort.send(Constants.killIsolate);
  }

  Future<Directory?> getDownloadPath() async {
    Directory? downloadsDirectory;

    if (Platform.isAndroid) {
      // Define the Downloads path for Android
      downloadsDirectory = Directory('/storage/emulated/0/Download');

      // Check if the directory exists, and create it if it doesn't
      if (!downloadsDirectory.existsSync()) {
        try {
          downloadsDirectory.createSync(recursive: true);
          log("Downloads directory created at: ${downloadsDirectory.path}");
        } catch (e) {
          log("Error creating Downloads directory: $e");
          return null;
        }
      }
    } else if (Platform.isIOS) {
      // On iOS, use Application Documents Directory
      downloadsDirectory = await getApplicationDocumentsDirectory();
      log("iOS does not have a dedicated Downloads folder like Android.");
    }

    return downloadsDirectory;
  }
}
