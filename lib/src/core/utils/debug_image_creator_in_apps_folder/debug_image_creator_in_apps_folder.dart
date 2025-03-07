import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';

class DebugImageCreatorInAppsFolder with FolderCreator {
  //

  DebugImageCreatorInAppsFolder({required final SharedPreferHelper sharedPreferHelper, Dio? dio})
    : _sharedPreferHelper = sharedPreferHelper,
      _dio = dio ?? Dio();

  final SharedPreferHelper _sharedPreferHelper;

  final Dio _dio;

  final String _key = "generated_images_in_folder";

  int get _randomInt {
    final Random rnd = Random();
    return rnd.nextInt(1000);
  }

  Future<void> createImagesInAppsFolder() async {
    final checkSet = _sharedPreferHelper.getBoolByKey(key: _key);

    debugPrint("images saved: $checkSet");

    if ((checkSet ?? false)) return;

    await _sharedPreferHelper.setBoolByKey(key: _key, value: true);

    final dir = await getApplicationDir();

    for (final each in foldersName) {
      for (int i = 0; i < 30; i++) {
        final response = await _dio.get<List<int>>(
          "https://picsum.photos/seed/$_randomInt/300/300",
          options: Options(responseType: ResponseType.bytes),
        );

        if (response.statusCode == HttpStatus.ok) {
          final pathImageForCreation = "${dir?.path}/$each/${DateTime.now()}.jpg";
          final File file = File(pathImageForCreation);
          if ((response.data ?? <int>[]).isNotEmpty) {
            file.writeAsBytesSync(response.data!);
          }
        }
      }
    }
  }
}
