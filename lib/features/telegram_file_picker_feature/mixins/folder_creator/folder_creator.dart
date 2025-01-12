import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/shared_preferences/shared_preferences.dart';

mixin class FolderCreator {
  // static FolderCreator? _instance;
  //
  // static FolderCreator get instance => _instance ??= FolderCreator._();
  //
  //
  // FolderCreator._();

  //
  void folderCreator({required String path}) {
    final directory = Directory(path);
    if (directory.existsSync()) return;
    directory.createSync();
  }

  // ----------------------------------------------

  final _foldersName = [
    "${Constants.appName} Audio",
    "${Constants.appName} Documents",
    "${Constants.appName} Files",
    "${Constants.appName} Images",
    "${Constants.appName} Videos",
  ];

  List<String> get foldersName => _foldersName;

  Future<Directory?> getApplicationDir() async => defaultTargetPlatform == TargetPlatform.iOS
      ? await getApplicationSupportDirectory()
      : await getExternalStorageDirectory();

  static Future<Directory?> getApplicationDirStatic() async =>
      defaultTargetPlatform == TargetPlatform.iOS
          ? await getApplicationSupportDirectory()
          : await getExternalStorageDirectory();

  Future<void> createFolders(SharedPreferHelper sharedPreferHelper) async {
    final isFoldersAlreadyCreated = sharedPreferHelper.getBoolByKey(
      key: "is_folders_created",
    );

    final dir = await getApplicationDir();

    if ((isFoldersAlreadyCreated ?? false)) return;

    for (final folderName in _foldersName) {
      final path = "${dir?.path}/$folderName";
      folderCreator(path: path);
    }

    await sharedPreferHelper.setBoolByKey(
      key: "is_folders_created",
      value: true,
    );
  }
}
