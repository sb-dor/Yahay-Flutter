import 'package:get_it/get_it.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/injections/add_contact_feature_inj/add_contact_feature_inj.dart';
import 'package:yahay/injections/blocs_inj/app_theme_bloc_inj/app_theme_bloc_inj.dart';
import 'package:yahay/injections/blocs_inj/auth_inj/auth_inj.dart';
import 'package:yahay/injections/blocs_inj/chat_screen_bloc_inj/chat_screen_bloc_inj.dart';
import 'package:yahay/injections/blocs_inj/chats_bloc_inj/chats_bloc_inj.dart';
import 'package:yahay/injections/blocs_inj/profile_bloc_inj/profile_bloc_inj.dart';
import 'package:yahay/injections/utils_inj/utils_inj.dart';

final snoopy = GetIt.instance;

abstract class Injections {
  static Future<void> init() async {
    // settings will be here
    await UtilsInj.utilsInj();

    snoopy.registerLazySingleton<DioSettings>(
      () => DioSettings(),
    );

    await snoopy<DioSettings>().init();

    await AppThemeBlocInj.appThemeBlocInj();

    await AuthInj.authInj();

    await AddContactFeatureInj.addContactFeatureInj();

    await ChatsAuthInj.chatsAuthInj();

    await ChatScreenBlocInj.chatScreenBlocInj();

    await ProfileBlocInj.profileBlocInj();
  }
}
