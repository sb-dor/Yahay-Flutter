import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:yahay/core/utils/permissions/permissions_service.dart';
import 'package:yahay/injections/injections.dart';

mixin class RecentFileMixin {
  final _permissions = snoopy<PermissionsService>();

  Stream<File?> getAllImagesAndVideos() async* {
    try {
      final externalStoragePermission = await _permissions.manageExternalStoragePermission();

      final storagePermission = await _permissions.storagePermission();

      if (!externalStoragePermission && !storagePermission) yield null;

      var images = await PhotoManager.getAssetListRange(
        start: 0,
        end: 100,
      );

      for (final asset in images) {
        // Get the file path of the asset
        File? file = await asset.file;
        if (file != null) {
          final kb = file.lengthSync() / 1024;
          final mb = kb / 1024;
          debugPrint("file mb sise: $mb");
          if (mb < 20) {
            yield file;
          }
        }
      }
    } catch (e) {
      debugPrint("getAllImagesAndVideos error is: $e");
      // return <File>[];
    }
  }
}
