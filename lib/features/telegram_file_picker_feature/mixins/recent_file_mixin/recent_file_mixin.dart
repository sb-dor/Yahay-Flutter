import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:yahay/core/utils/permissions/permissions_service.dart';
import 'package:yahay/injections/injections.dart';

mixin class CompressImage {}

mixin class RecentFileMixin {
  final _permissions = snoopy<PermissionsService>();

  // final _context = snoopy<GlobalContext>().globalContext.currentContext!;

  // final _reusableFunctions = snoopy<ReusableGlobalFunctions>();

  Stream<File?> getAllImagesAndVideos() async* {
    try {
      final externalStoragePermission = await _permissions.manageExternalStoragePermission();

      final storagePermission = await _permissions.storagePermission();

      if (!externalStoragePermission && !storagePermission) return;

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
            // if (_reusableFunctions.isVideoFile(file.path)) {
            //   yield file;
            //   continue;
            // }
            // final compressedFile = _compressedFile(file);
            // if (_context.mounted) precacheImage(FileImage(file), _context);
            await DefaultCacheManager().putFile(
              file.path,
              file.readAsBytesSync(),
              maxAge: const Duration(days: 1),
            );
            yield file;
          }
        }
      }
    } catch (e) {
      debugPrint("getAllImagesAndVideos error is: $e");
      // return <File>[];
    }
  }

// Future<File?> _compressedFile(File? file) async {
//   if (file == null) return null;
//
//   final tempDir = await getTemporaryDirectory();
//   final filePath = file.absolute.path;
//   final fileName = path.basename(filePath);
//   final outPath = path.join(tempDir.path, 'compressed_$fileName');
//
//   final res = await FlutterImageCompress.compressAndGetFile(
//     file.path,
//     outPath,
//     quality: 30,
//   );
//
//   final fileFromCompressedImage = File(res?.path ?? '');
//
//   if (!fileFromCompressedImage.existsSync()) return null;
//
//   return fileFromCompressedImage;
// }
}
