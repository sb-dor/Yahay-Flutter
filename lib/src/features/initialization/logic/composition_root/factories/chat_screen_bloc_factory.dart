import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/features/chat_screen/bloc/chat_screen_bloc.dart';
import 'package:yahay/src/features/chat_screen/bloc/state_model/chat_screen_state_model.dart';
import 'package:yahay/src/features/chat_screen/data/repo/chat_screen_chat_repo_impl.dart';
import 'package:yahay/src/features/chat_screen/data/repo/chat_screen_repo_impl.dart';
import 'package:yahay/src/features/chat_screen/data/sources/chat_screen_chat_data_source/chat_screen_chat_data_souce.dart';
import 'package:yahay/src/features/chat_screen/data/sources/chat_screen_chat_data_source/impl/chat_screen_chat_data_souce.dart';
import 'package:yahay/src/features/chat_screen/data/sources/chat_screen_message_data_source/chat_screen_message_data_source.dart';
import 'package:yahay/src/features/chat_screen/data/sources/chat_screen_message_data_source/impl/chat_screen_message_data_source_impl.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_chat_repo.dart';
import 'package:yahay/src/features/chat_screen/domain/repo/chat_screen_repo.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';

final class ChatScreenBlocFactory extends Factory<ChatScreenBloc> {
  final User? user;
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

    const initialState = ChatScreenStates.initial(ChatScreenStateModel());

    return ChatScreenBloc(
      chatScreenRepo: chatScreenRepo,
      chatScreenChatRepo: chatScreenChatRepo,
      currentUser: user,
      options: _channelsOptions,
      initialState: initialState,
    );
  }
}
