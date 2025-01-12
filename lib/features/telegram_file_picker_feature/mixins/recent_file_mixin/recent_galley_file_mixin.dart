import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/core/utils/image_comporessor/image_compressor.dart';
import 'package:yahay/core/utils/permissions/permissions_service.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_path_folder_file_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_asset_entity.dart';

mixin class RecentGalleyFileMixin {
  // final _context = snoopy<GlobalContext>().globalContext.currentContext!;

  // final _reusableFunctions = snoopy<ReusableGlobalFunctions>();

  Stream<TelegramPathFolderFileModel?> getAllImagesAndVideos({
    RecentFilesOptions? options,
  }) async* {
    try {
      final PermissionsService permissionsService = PermissionsService();

      final externalStoragePermission = await permissionsService.manageExternalStoragePermission();

      final storagePermission = await permissionsService.storagePermission();

      debugPrint("storage $storagePermission | external: $externalStoragePermission");

      if (!externalStoragePermission || !storagePermission) return;

      List<TelegramFileImageAssetEntity> toEncodeList = await _RecentFilesHelper(
        options: options,
      ).getAssets();

      final ReceivePort receivePort = ReceivePort();

      final rootIsolateToken = RootIsolateToken.instance!;

      Map<String, dynamic> toIsolateImages = {
        "list": toEncodeList.map((e) {
          return e.toJson();
        }).toList(),
      };

      debugPrint("type of isolate image: ${jsonEncode(toIsolateImages)}");

      Isolate.spawn(_isolateFileSender, [
        rootIsolateToken,
        receivePort.sendPort,
        jsonEncode(toIsolateImages),
      ]);

      await for (final each in receivePort) {
        if (each is TelegramPathFolderFileModel) {
          yield each;
        } else if (each is String && each == Constants.killIsolate) {
          receivePort.close();
          break;
        }
      }
    } catch (e) {
      debugPrint("getAllImagesAndVideos error is: $e");
      // return <File>[];
    }
  }

  static Future<void> _isolateFileSender(List<dynamic> args) async {
    RootIsolateToken rootIsolateToken = args[0];

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    final SendPort sendPort = args[1];

    Map<String, dynamic> telegramImageAssetEntity = jsonDecode(args[2]);

    List<dynamic> dList = telegramImageAssetEntity['list'];

    final reusables = ReusableGlobalFunctions.instance;

    final List<TelegramFileImageAssetEntity> images =
        dList.map((e) => TelegramFileImageAssetEntity.fromJson(e)).toList();

    final tempPath = await getTemporaryDirectory();

    for (final asset in images) {
      // Get the file path of the asset
      File file = File(asset.imagePath);
      if (file.existsSync()) {
        final kb = file.lengthSync() / 1024;
        final mb = kb / 1024;
        // debugPrint("file mb sise: $mb");
        if (mb < 20) {
          // if (_reusableFunctions.isVideoFile(file.path)) {
          //   yield file;
          //   continue;
          // }
          // final compressedFile = _compressedFile(file);
          // if (_context.mounted) precacheImage(FileImage(file), _context);
          // await DefaultCacheManager().putFile(
          //   file.path,
          //   file.readAsBytesSync(),
          //   maxAge: const Duration(days: 1),
          // );
          if (reusables.isImageFile(asset.imagePath)) {
            final compressedFile = await ImageCompressor.compressedImageFile(
              file: file,
              directoryPath: tempPath.path,
              quality: 30,
            );

            sendPort.send(compressedFile);
          } else {
            sendPort.send(file);
          }
        }
      }
    }

    sendPort.send(Constants.killIsolate);
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

class RecentFilesOptions {
  final bool getAll;
  final int? start;
  final int? end;

  RecentFilesOptions({this.getAll = false, this.start, this.end});
}

abstract interface class _RecentFilesHelper {
  Future<List<TelegramFileImageAssetEntity>> getAssets();

  factory _RecentFilesHelper({
    RecentFilesOptions? options,
  }) {
    switch (options?.getAll) {
      case null:
      case false:
        return _GetRangedAssetFiles(
          start: options?.start,
          end: options?.end,
        );
      case true:
        return _GetAllAssetFiles();
    }
  }
}

class _GetRangedAssetFiles implements _RecentFilesHelper {
  final int? start;
  final int? end;

  _GetRangedAssetFiles({this.start, this.end});

  @override
  Future<List<TelegramFileImageAssetEntity>> getAssets() async {
    var images = await PhotoManager.getAssetListRange(
      start: start ?? 0,
      end: end ?? 100,
    );

    List<TelegramFileImageAssetEntity> list = [];

    for (final image in images) {
      final file = await image.file;
      if (file == null) continue;
      list.add(TelegramFileImageAssetEntity(file.absolute.path));
    }
    return list;
  }
}

class _GetAllAssetFiles implements _RecentFilesHelper {
  @override
  Future<List<TelegramFileImageAssetEntity>> getAssets() async {
    var images = await PhotoManager.getAssetPathList();
    List<TelegramFileImageAssetEntity> list = [];
    for (final assetPath in images) {
      // Fetch all assets in the album
      final assets = await assetPath.getAssetListPaged(
        page: 0, // Start with the first page
        size: await assetPath.assetCountAsync, // Fetch all assets in one go
      );

      for (final asset in assets) {
        final file = await asset.file;
        if (file == null) continue;
        list.add(TelegramFileImageAssetEntity(file.absolute.path));
      }
    }
    return list;
  }
}
