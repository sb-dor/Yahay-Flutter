import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';

class SingleCameraViewScreen extends StatelessWidget {
  const SingleCameraViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: RTCVideoView(
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        filterQuality: FilterQuality.none,
        mirror: true,
        context
            .read<VideoChatBloc>()
            .state
            .videoChatStateModel
            .currentVideoChatEntity!
            .videoRenderer!,
      ),
    );
  }
}

//return Positioned.fill(
//       child: CameraPreview(
//         videoChatBloc.states.value.videoChatStateModel.mainVideoStreamCameraController!,
//       ),
//     );
