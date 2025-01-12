import 'package:yahay/features/chat_screen/data/repo/chat_screen_chat_repo_impl.dart';
import 'package:yahay/features/chat_screen/data/repo/chat_screen_repo_impl.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_chat_data_source/chat_screen_chat_data_souce.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_chat_data_source/impl/chat_screen_chat_data_souce.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_message_data_source/chat_screen_message_data_source.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_message_data_source/impl/chat_screen_message_data_source_impl.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';
import 'package:yahay/features/chat_screen/domain/repo/chat_screen_repo.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/features/initialization/logic/composition_root/composition_root.dart';

final class ChatScreenBlocFactory extends Factory<ChatScreenBloc> {
  @override
  ChatScreenBloc create() {
    final ChatScreenMessageDataSource messageDataSource = ChatScreenMessageDataSourceImpl();

    final ChatScreenChatDataSource chatScreenChatDataSource = ChatScreenChatDataSourceImpl();

    final ChatScreenRepo chatScreenRepo = ChatScreenRepoImpl(messageDataSource);

    final ChatScreenChatRepo chatScreenChatRepo = ChatScreenChatRepoImpl(
      chatScreenChatDataSource,
    );

    return ChatScreenBloc(
      chatScreenRepo: chatScreenRepo,
      chatScreenChatRepo: chatScreenChatRepo,
    );
  }
}
