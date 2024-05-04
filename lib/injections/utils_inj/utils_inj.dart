import 'package:yahay/core/utils/shared_preferences.dart';
import 'package:yahay/injections/injections.dart';

abstract class UtilsInj {
  static Future<void> utilsInj() async {
    snoopy.registerLazySingleton<SharedPreferHelper>(
      () => SharedPreferHelper(),
    );
    //
  }
}
