import 'package:yahay/features/chats/data/repo/chat_repo_impl.dart';
import 'package:yahay/features/chats/data/sources/chats_data_source/chats_data_source.dart';
import 'package:yahay/features/chats/data/sources/chats_data_source/impl/chats_data_source_impl.dart';
import 'package:yahay/features/chats/domain/repo/chats_repo.dart';
import 'package:yahay/features/chats/view/bloc/chats_bloc.dart';
import 'package:yahay/features/initialization/logic/composition_root/composition_root.dart';

final class ChatsBlocFactory extends Factory<ChatsBloc> {
  @override
  ChatsBloc create() {
    final ChatsDataSource chatsDataSource = ChatsDataSourceImpl();

    final ChatsRepo chatsRepo = ChatsRepoImpl(chatsDataSource);

    return ChatsBloc(
      chatsRepo: chatsRepo,
    );
  }
}
