import 'package:logger/logger.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/state_model/video_chat_state_model.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/src/features/video_chat_feature/data/video_chat_feature_data_source.dart';
import 'package:yahay/src/features/video_chat_feature/data/video_chat_feature_repo.dart';

final class VideoChatBlocFactory extends Factory<VideoChatBloc> {
  VideoChatBlocFactory(
    this._user,
    this._pusherClientService,
    this._logger,
  );

  final UserModel? _user;
  final PusherClientService _pusherClientService;
  final Logger _logger;

  @override
  VideoChatBloc create() {
    //

    final VideoChatFeatureDataSource videoChatFeatureDataSource = VideoChatFeatureDataSourceImpl();

    final VideoChatFeatureRepo videoChatFeatureRepo = VideoChatFeatureRepoImpl(
      videoChatFeatureDataSource,
    );

    final initialState = VideoChatFeatureStates.initialVideoChatState(VideoChatStateModel.idle());

    return VideoChatBloc(
      iVideoChatFeatureRepo: videoChatFeatureRepo,
      currentUser: _user,
      pusherClientService: _pusherClientService,
      initialState: initialState,
      logger: _logger,
    );
  }
}
