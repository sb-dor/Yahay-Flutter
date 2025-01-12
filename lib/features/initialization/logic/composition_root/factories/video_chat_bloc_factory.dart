import 'package:yahay/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/features/video_chat_feature/data/repo/video_chat_feature_repo_impl.dart';
import 'package:yahay/features/video_chat_feature/data/sources/video_chat_feature_data_source/impl/video_chat_feature_data_source_impl.dart';
import 'package:yahay/features/video_chat_feature/data/sources/video_chat_feature_data_source/video_chat_feature_data_source.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';

final class VideoChatBlocFactory extends Factory<VideoChatFeatureBloc> {
  @override
  VideoChatFeatureBloc create() {
    //

    final VideoChatFeatureDataSource videoChatFeatureDataSource = VideoChatFeatureDataSourceImpl();

    final VideoChatFeatureRepo videoChatFeatureRepo = VideoChatFeatureRepoImpl(
      videoChatFeatureDataSource,
    );

    return VideoChatFeatureBloc(
      repo: videoChatFeatureRepo,
    );
  }
}
