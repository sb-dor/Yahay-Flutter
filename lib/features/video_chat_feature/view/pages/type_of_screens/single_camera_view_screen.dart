import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
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
      child: Column(
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: RTCVideoView(
              videoChatBloc.states.value.videoChatStateModel.localRenderer!,
            ),
          )
        ],
      ),
    );
  }
}

//return Positioned.fill(
//       child: CameraPreview(
//         videoChatBloc.states.value.videoChatStateModel.mainVideoStreamCameraController!,
//       ),
//     );
