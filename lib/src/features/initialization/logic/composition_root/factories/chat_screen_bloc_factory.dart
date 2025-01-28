import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
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
  ChatScreenBlocFactory({
    required final UserModel? user,
    required final PusherChannelsOptions channelsOptions,
    required final DioSettings dioSettings,
  })  : _user = user,
        _channelsOptions = channelsOptions,
        _dioSettings = dioSettings;

  final UserModel? _user;
  final PusherChannelsOptions _channelsOptions;
  final DioSettings _dioSettings;

  @override
  ChatScreenBloc create() {
    final ChatScreenMessageDataSource messageDataSource = ChatScreenMessageDataSourceImpl(
      dioSettings: _dioSettings,
    );

    final ChatScreenChatDataSource chatScreenChatDataSource = ChatScreenChatDataSourceImpl(
      dioSettings: _dioSettings,
    );

    final ChatScreenRepo chatScreenRepo = ChatScreenRepoImpl(messageDataSource);

    final ChatScreenChatRepo chatScreenChatRepo = ChatScreenChatRepoImpl(
      chatScreenChatDataSource,
    );

    const initialState = ChatScreenStates.initial(ChatScreenStateModel());

    return ChatScreenBloc(
      chatScreenRepo: chatScreenRepo,
      chatScreenChatRepo: chatScreenChatRepo,
      currentUser: _user,
      options: _channelsOptions,
      initialState: initialState,
    );
  }
}
