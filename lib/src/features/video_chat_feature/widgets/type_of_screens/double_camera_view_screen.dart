import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';

class DoubleCameraViewScreen extends StatefulWidget {
  const DoubleCameraViewScreen({super.key});

  @override
  State<DoubleCameraViewScreen> createState() => _DoubleCameraViewScreenState();
}

class _DoubleCameraViewScreenState extends State<DoubleCameraViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoChatBloc, VideoChatFeatureStates>(
      builder: (context, state) {
        return Positioned.fill(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: RTCVideoView(
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    state.videoChatStateModel.videoChatEntities.first.videoRenderer!,
                  ),
                ),
                const Divider(
                  height: 0,
                  color: Colors.black12,
                ),
                Expanded(
                  child: RTCVideoView(
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    state.videoChatStateModel.currentVideoChatEntity!.videoRenderer!,
                    mirror: !state.videoChatStateModel.cameraSwitched,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
