import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';

class SingleCameraViewScreen extends StatelessWidget {
  final VideoChatBloc videoChatBloc;

  const SingleCameraViewScreen({
    super.key,
    required this.videoChatBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: RTCVideoView(
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        filterQuality: FilterQuality.none,
        mirror: true,
        videoChatBloc.state.videoChatStateModel.currentVideoChatEntity!.videoRenderer!,
      ),
    );
  }
}

//return Positioned.fill(
//       child: CameraPreview(
//         videoChatBloc.states.value.videoChatStateModel.mainVideoStreamCameraController!,
//       ),
//     );
