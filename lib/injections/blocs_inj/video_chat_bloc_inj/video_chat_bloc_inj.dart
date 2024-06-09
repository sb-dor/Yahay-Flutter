import 'package:yahay/features/video_chat_feature/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/features/video_chat_feature/data/repo/video_chat_feature_repo_impl.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class VideoChatBlocInj {
  static Future<void> videochatBlocInj() async {
    snoopy.registerLazySingleton<CameraHelperService>(
      () => CameraHelperService(),
    );

    await snoopy<CameraHelperService>().initCameras();

    snoopy.registerLazySingleton<VideoChatFeatureRepo>(
      () => VideoChatFeatureRepoImpl(),
    );

    snoopy.registerFactory<VideoChatFeatureBloc>(
      () => VideoChatFeatureBloc(
        repo: snoopy<VideoChatFeatureRepo>(),
      ),
    );
  }
}
