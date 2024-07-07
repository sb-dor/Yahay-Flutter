import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:yahay/core/utils/permissions/permissions_service.dart';
import 'package:yahay/core/utils/reusables/reusable_global_functions.dart';
import 'package:yahay/injections/injections.dart';

class FilePickerUseCase {
  final _permissions = snoopy<PermissionsService>();

  Future<List<File>> getAllImagesAndVideos() async {
    try {
      final externalStoragePermission = await _permissions.manageExternalStoragePermission();

      final storagePermission = await _permissions.storagePermission();

      if (!externalStoragePermission && !storagePermission) return <File>[];

      List<File> mediaPath = [];

      var images = await PhotoManager.getAssetListRange(
        start: 0,
        end: 100,
      );

      // for (final pathEntity in images) {
      //   // Get the assets in the current album
      //   List<AssetEntity> assets = await pathEntity.getAssetListRange(
      //     start: 0,
      //     end: await pathEntity.assetCountAsync,
      //   );

      for (final asset in images) {
        // Get the file path of the asset
        File? file = await asset.file;
        if (file != null) {
          final kb = file.lengthSync() / 1024;
          final mb = kb / 1024;
          debugPrint("file mb sise: $mb");
          if (mb > 1 && mb < 20) {
            mediaPath.add(file);
          }
        }
      }
      // }

      mediaPath = await snoopy<ReusableGlobalFunctions>().removeDuplicatesFromList<File>(
        list: mediaPath,
        test: (el, el2) => el.path == el2.path,
      );

      return mediaPath;
    } catch (e) {
      debugPrint("getAllImagesAndVideos error is: $e");
      return <File>[];
    }
  }
}
