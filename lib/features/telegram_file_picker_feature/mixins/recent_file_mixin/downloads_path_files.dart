import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:lecle_downloads_path_provider/constants/downloads_directory_type.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/core/utils/permissions/permissions_service.dart';
import 'package:yahay/injections/injections.dart';

mixin class DownloadsPathFiles {
  final _permissions = snoopy<PermissionsService>();

  Stream<File?> downloadsPathFilesData({
    String dirType = DownloadDirectoryTypes.downloads,
  }) async* {
    try {
      final externalStoragePermission = await _permissions.manageExternalStoragePermission();

      final storagePermission = await _permissions.storagePermission();

      if (!externalStoragePermission && !storagePermission) return;

      Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory(
        dirType: dirType,
      );

      if (downloadsDirectory == null) return;

      yield* downloadsDirectory.list().switchMap<File?>((e) async* {
        debugPrint("downloads path file: $e");
        yield File(e.path);
      });
    } catch (e) {
      debugPrint("downloadsPathFilesData error is: $e");
    }
  }
}
