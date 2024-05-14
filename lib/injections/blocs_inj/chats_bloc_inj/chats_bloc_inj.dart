import 'package:yahay/features/chats/data/repo/chat_repo_impl.dart';
import 'package:yahay/features/chats/data/sources/chats_data_source/chats_data_source.dart';
import 'package:yahay/features/chats/data/sources/chats_data_source/impl/chats_data_source_impl.dart';
import 'package:yahay/features/chats/domain/repo/chats_repo.dart';
import 'package:yahay/features/chats/view/bloc/chats_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class ChatsAuthInj {
  static Future<void> chatsAuthInj() async {
    snoopy.registerLazySingleton<ChatsDataSource>(
      () => ChatsDataSourceImpl(),
    );

    snoopy.registerLazySingleton<ChatsRepo>(
      () => ChatsRepoImpl(
        snoopy<ChatsDataSource>(),
      ),
    );

    snoopy.registerLazySingleton<ChatsBloc>(
      () => ChatsBloc(
        chatsRepo: snoopy<ChatsRepo>(),
      ),
    );
  }
}
