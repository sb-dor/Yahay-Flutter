import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:lecle_downloads_path_provider/constants/downloads_directory_type.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/core/utils/permissions/permissions_service.dart';
import 'package:yahay/injections/injections.dart';

mixin class DownloadsPathFiles {
  final _permissions = snoopy<PermissionsService>();

  // final _reusables = snoopy<ReusableGlobalFunctions>();

  Stream<File?> downloadsPathFilesData({
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
        if (each is File) {
          yield each;
        } else if (each == null) {
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
    final Directory? directory = Directory(args[1]);
    final rootIsolateToken = args[2] as RootIsolateToken;

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    if (!GetIt.instance.isRegistered<ReusableGlobalFunctions>()) {
      GetIt.instance.registerLazySingleton<ReusableGlobalFunctions>(
        () => ReusableGlobalFunctions(),
      );
    }


    final defaultCacheManager = DefaultCacheManager();

    final reusables = GetIt.instance.get<ReusableGlobalFunctions>();

    if (directory == null) return;
    await for (final entity in directory.list(recursive: false, followLinks: false)) {
      if (FileSystemEntity.isDirectorySync(entity.path)) {
        await _fileFinder([receivingPort, entity.path, rootIsolateToken]);
      }
      if (FileSystemEntity.isFileSync(entity.path)) {
        final file = File(entity.path);
        if (reusables.isImageFile(file.path)) {
          final fileBytes = await file.readAsBytes();
          // await defaultCacheManager.putFile(
          //   file.path,
          //   fileBytes,
          //   maxAge: const Duration(days: 1),
          // );
          receivingPort.send(file);
        }
      }
    }
  }
}

