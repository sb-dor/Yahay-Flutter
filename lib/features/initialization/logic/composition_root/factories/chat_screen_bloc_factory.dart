import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/core/global_data/entities/user.dart';
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
  final User user;
  final PusherChannelsOptions _channelsOptions;

  ChatScreenBlocFactory(
    this.user,
    this._channelsOptions,
  );

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
      user: user,
      options: _channelsOptions,
    );
  }
}
