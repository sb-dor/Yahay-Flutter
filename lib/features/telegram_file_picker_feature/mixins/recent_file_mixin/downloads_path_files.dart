import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lecle_downloads_path_provider/constants/downloads_directory_type.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/core/utils/permissions/permissions_service.dart';
import 'package:yahay/injections/injections.dart';

mixin class DownloadsPathFiles {
  final _permissions = snoopy<PermissionsService>();

  final _reusables = snoopy<ReusableGlobalFunctions>();

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

      await for (final entity in downloadsDirectory.list(recursive: false, followLinks: false)) {
        if (await FileSystemEntity.isFile(entity.path)) {
          final file = File(entity.path);
          if (_reusables.isImageFile(file.path)) {
            final fileBytes = await file.readAsBytes();
            await DefaultCacheManager().putFile(
              file.path,
              fileBytes,
              maxAge: const Duration(days: 1),
            );
            yield file;
          }
        }
      }
    } catch (e) {
      debugPrint("downloadsPathFilesData error is: $e");
    }
  }
}
