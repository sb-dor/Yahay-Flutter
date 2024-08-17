import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';
import 'package:yahay/injections/injections.dart';

class DebugImageCreatorInAppsFolder with FolderCreator {
  //
  static const String _key = "generated_images_in_folder";

  final SharedPreferHelper _sharedPreferHelper = snoopy<SharedPreferHelper>();

  final DioSettings _dioSettings = snoopy<DioSettings>();

  int get _randomInt {
    Random rnd = Random();
    return rnd.nextInt(1000);
  }

  Future<void> createImagesInAppsFolder() async {
    final checkSet = _sharedPreferHelper.getBoolByKey(key: _key);

    if ((checkSet ?? false)) return;

    await _sharedPreferHelper.setBoolByKey(key: _key, value: true);

    final dir = await getApplicationDir();

    for (final each in foldersName) {
      for (int i = 0; i < 30; i++) {
        final response = await _dioSettings.dio.get<List<int>>(
          "https://picsum.photos/seed/$_randomInt/300/300",
          options: Options(responseType: ResponseType.bytes),
        );

        if (response.statusCode == HttpStatusCodes.success) {
          final pathImageForCreation = "${dir?.path}/$each/${DateTime.now()}.jpg";
          File file = File(pathImageForCreation);
          if ((response.data ?? <int>[]).isNotEmpty) {
            file.writeAsBytesSync(response.data!);
          }
        }
      }
    }
  }
}
