import 'package:yahay/core/utils/dotenv/dotenv.dart';
import 'package:yahay/core/utils/global_context/global_context.dart';
import 'package:yahay/core/utils/list_pagination_checker/list_pagination_checker.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/core/utils/screen_messaging/screen_messaging.dart';
import 'package:yahay/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/injections/injections.dart';

abstract class UtilsInj {
  static Future<void> utilsInj() async {
    snoopy.registerLazySingleton<GlobalContext>(() => GlobalContext());

    snoopy.registerLazySingleton<SharedPreferHelper>(
      () => SharedPreferHelper(),
    );

    await snoopy<SharedPreferHelper>().initSharedPrefer();
    //
    snoopy.registerLazySingleton<DotEnvHelper>(
      () => DotEnvHelper(),
    );

    await snoopy<DotEnvHelper>().initEnv();

    snoopy.registerLazySingleton<PusherClientService>(
      () => PusherClientService(),
    );

    snoopy.registerLazySingleton<ScreenMessaging>(() => ScreenMessaging());

    snoopy.registerLazySingleton<ListPaginationChecker>(
      () => ListPaginationChecker(),
    );
  }
}
