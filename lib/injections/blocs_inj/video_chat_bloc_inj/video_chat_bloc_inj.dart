import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class VideoChatBlocInj {
  static Future<void> videochatBlocInj() async {
    snoopy.registerLazySingleton<VideoChatFeatureBloc>(
      () => VideoChatFeatureBloc(),
    );
  }
}
