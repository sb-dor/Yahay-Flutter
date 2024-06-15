import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';

class SingleCameraViewScreen extends StatelessWidget {
  final VideoChatFeatureBloc videoChatBloc;

  const SingleCameraViewScreen({
    super.key,
    required this.videoChatBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CameraPreview(
        videoChatBloc.states.value.videoChatStateModel.mainVideoStreamCameraController!,
      ),
    );
  }
}