import 'package:yahay/features/video_chat_feature/data/repo/video_chat_feature_repo_impl.dart';
import 'package:yahay/features/video_chat_feature/data/sources/video_chat_feature_data_source/impl/video_chat_feature_data_source_impl.dart';
import 'package:yahay/features/video_chat_feature/data/sources/video_chat_feature_data_source/video_chat_feature_data_source.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/features/video_chat_feature/webrtc_helper/webrtc_laravel_helper.dart';
import 'package:yahay/injections/injections.dart';

abstract class VideoChatBlocInj {
  static Future<void> videochatBlocInj() async {
    // snoopy.registerLazySingleton<CameraHelperService>(
    //   () => CameraHelperService(),
    // );
    //
    // await snoopy<CameraHelperService>().initCameras();

    // snoopy.registerLazySingleton(
    //   () => WebrtcLaravelHelper(),
    // );

    snoopy.registerLazySingleton<VideoChatFeatureDataSource>(
      () => VideoChatFeatureDataSourceImpl(),
    );

    snoopy.registerLazySingleton<VideoChatFeatureRepo>(
      () => VideoChatFeatureRepoImpl(
        snoopy<VideoChatFeatureDataSource>(),
      ),
    );

    snoopy.registerFactory<VideoChatFeatureBloc>(
      () => VideoChatFeatureBloc(
        repo: snoopy<VideoChatFeatureRepo>(),
      ),
    );
  }
}
