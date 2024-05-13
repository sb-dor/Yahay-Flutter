import 'package:yahay/features/chat_screen/data/repo/chat_screen_chat_repo_impl.dart';
import 'package:yahay/features/chat_screen/data/repo/chat_screen_repo_impl.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_chat_data_source/chat_screen_chat_data_souce.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_chat_data_source/impl/chat_screen_chat_data_souce.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_message_data_source/chat_screen_message_data_source.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_message_data_source/impl/chat_screen_message_data_source_impl.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_repo.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class ChatScreenBlocInj {
  static Future<void> chatScreenBlocInj() async {
    snoopy.registerLazySingleton<ChatScreenMessageDataSource>(
      () => ChatScreenMessageDataSourceImpl(),
    );

    snoopy.registerLazySingleton<ChatScreenChatDataSource>(
      () => ChatScreenChatDataSourceImpl(),
    );

    snoopy.registerLazySingleton<ChatScreenChatRepo>(
      () => ChatScreenChatRepoImpl(
        snoopy<ChatScreenChatDataSource>(),
      ),
    );

    snoopy.registerLazySingleton<ChatScreenRepo>(
      () => ChatScreenRepoImpl(
        snoopy<ChatScreenMessageDataSource>(),
      ),
    );

    snoopy.registerFactory<ChatScreenBloc>(
      () => ChatScreenBloc(
        chatScreenRepo: snoopy<ChatScreenRepo>(),
        chatScreenChatRepo: snoopy<ChatScreenChatRepo>(),
      ),
    );
  }
}
