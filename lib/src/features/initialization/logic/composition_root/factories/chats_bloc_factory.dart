import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';
import 'package:yahay/src/features/chats/bloc/chats_bloc.dart';
import 'package:yahay/src/features/chats/bloc/state_model/chats_state_model.dart';
import 'package:yahay/src/features/chats/data/repo/chat_repo_impl.dart';
import 'package:yahay/src/features/chats/data/sources/chats_data_source/chats_data_source.dart';
import 'package:yahay/src/features/chats/data/sources/chats_data_source/impl/chats_data_source_impl.dart';
import 'package:yahay/src/features/chats/domain/repo/chats_repo.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';

final class ChatsBlocFactory extends Factory<ChatsBloc> {
  ChatsBlocFactory({
    required final UserModel? currentUser,
    required final PusherChannelsOptions pusherChannelsOption,
    required final Logger logger,
    required final RestClientBase restClientBase
  })  : _currentUser = currentUser,
        _pusherChannelsOptions = pusherChannelsOption,
        _logger = logger,
        _restClientBase = restClientBase;

  final UserModel? _currentUser;
  final PusherChannelsOptions _pusherChannelsOptions;
  final Logger _logger;
  final RestClientBase _restClientBase;

  @override
  ChatsBloc create() {
    final ChatsDataSource chatsDataSource = ChatsDataSourceImpl(
      restClientBase: _restClientBase,
    );

    final ChatsRepo chatsRepo = ChatsRepoImpl(chatsDataSource);

    final initialState = ChatsStates.initial(ChatsStateModel.idle());

    return ChatsBloc(
      chatsRepo: chatsRepo,
      currentUser: _currentUser,
      pusherChannelsOptions: _pusherChannelsOptions,
      logger: _logger,
      initialState: initialState,
    );
  }
}
