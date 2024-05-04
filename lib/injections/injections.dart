import 'package:get_it/get_it.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/injections/utils_inj/utils_inj.dart';

final snoopy = GetIt.instance;

abstract class Injections {
  static Future<void> init() async {
    // settings will be here
    await UtilsInj.utilsInj();

    snoopy.registerLazySingleton<DioSettings>(
      () => DioSettings(),
    );
  }
}
