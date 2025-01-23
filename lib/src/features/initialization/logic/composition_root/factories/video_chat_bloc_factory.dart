import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/src/features/video_chat_feature/data/repo/video_chat_feature_repo_impl.dart';
import 'package:yahay/src/features/video_chat_feature/data/sources/video_chat_feature_data_source/impl/video_chat_feature_data_source_impl.dart';
import 'package:yahay/src/features/video_chat_feature/data/sources/video_chat_feature_data_source/video_chat_feature_data_source.dart';
import 'package:yahay/src/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';
import 'package:yahay/src/features/video_chat_feature/widgets/bloc/video_chat_feature_bloc.dart';

final class VideoChatBlocFactory extends Factory<VideoChatFeatureBloc> {
  VideoChatBlocFactory(
    this._user,
    this._pusherClientService,
  );

  final User? _user;
  final PusherClientService _pusherClientService;

  @override
  VideoChatFeatureBloc create() {
    //

    final VideoChatFeatureDataSource videoChatFeatureDataSource = VideoChatFeatureDataSourceImpl();

    final VideoChatFeatureRepo videoChatFeatureRepo = VideoChatFeatureRepoImpl(
      videoChatFeatureDataSource,
    );

    return VideoChatFeatureBloc(
      repo: videoChatFeatureRepo,
      currentUser: _user,
      pusherClientService: _pusherClientService,
    );
  }
}
