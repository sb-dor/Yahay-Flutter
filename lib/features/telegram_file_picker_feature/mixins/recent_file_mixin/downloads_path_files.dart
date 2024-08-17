import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lecle_downloads_path_provider/constants/downloads_directory_type.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/core/utils/image_comporessor/image_compressor.dart';
import 'package:yahay/core/utils/permissions/permissions_service.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_with_compressed_and_original_path_model.dart';
import 'package:yahay/injections/injections.dart';

mixin class DownloadsPathFiles {
  final _permissions = snoopy<PermissionsService>();

  // final _reusables = snoopy<ReusableGlobalFunctions>();

  Stream<TelegramPathFolderFileModel?> downloadsPathFilesData({
    String dirType = DownloadDirectoryTypes.downloads,
  }) async* {
    try {
      // final externalStoragePermission = await _permissions.manageExternalStoragePermission();
      //
      // final storagePermission = await _permissions.storagePermission();
      //
      // if (!externalStoragePermission && !storagePermission) return;

      Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory(
        dirType: dirType,
      );

      // debugPrint("downloades dir: $downloadsDirectory");

      if (downloadsDirectory == null) return;

      ReceivePort sendingPort = ReceivePort();

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

    if (!GetIt.instance.isRegistered<ReusableGlobalFunctions>()) {
      GetIt.instance.registerLazySingleton<ReusableGlobalFunctions>(
        () => ReusableGlobalFunctions(),
      );
    }

    // final defaultCacheManager = DefaultCacheManager();

    final reusables = GetIt.instance.get<ReusableGlobalFunctions>();

    final directoryPath = await getTemporaryDirectory();
    await for (final entity in directory.list(recursive: false, followLinks: false)) {
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
}
