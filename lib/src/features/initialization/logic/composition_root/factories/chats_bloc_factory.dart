import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/features/chats/bloc/chats_bloc.dart';
import 'package:yahay/src/features/chats/bloc/state_model/chats_state_model.dart';
import 'package:yahay/src/features/chats/data/repo/chat_repo_impl.dart';
import 'package:yahay/src/features/chats/data/sources/chats_data_source/chats_data_source.dart';
import 'package:yahay/src/features/chats/data/sources/chats_data_source/impl/chats_data_source_impl.dart';
import 'package:yahay/src/features/chats/domain/repo/chats_repo.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';

final class ChatsBlocFactory extends Factory<ChatsBloc> {
  final User? _currentUser;
  final PusherChannelsOptions _pusherChannelsOptions;
  final Logger _logger;

  ChatsBlocFactory(
      {required User? currentUser,
      required PusherChannelsOptions pusherChannelsOption,
      required Logger logger,
      r})
      : _currentUser = currentUser,
        _pusherChannelsOptions = pusherChannelsOption,
        _logger = logger;

  @override
  ChatsBloc create() {
    final ChatsDataSource chatsDataSource = ChatsDataSourceImpl();

    final ChatsRepo chatsRepo = ChatsRepoImpl(chatsDataSource);

    final initialState = ChatsStates.initial(ChatsStateModel());

    return ChatsBloc(
      chatsRepo: chatsRepo,
      currentUser: _currentUser,
      pusherChannelsOptions: _pusherChannelsOptions,
      logger: _logger,
      initialState: initialState,
    );
  }
}
