import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:yahay/src/features/video_chat_feature/view/bloc/state_model/video_chat_state_model.dart';
import 'package:yahay/src/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';

class DoubleCameraViewScreen extends StatefulWidget {
  final VideoChatFeatureBloc videoChatBloc;

  const DoubleCameraViewScreen({
    super.key,
    required this.videoChatBloc,
  });

  @override
  State<DoubleCameraViewScreen> createState() => _DoubleCameraViewScreenState();
}

class _DoubleCameraViewScreenState extends State<DoubleCameraViewScreen> {
  late VideoChatFeatureBloc _videoChatFeatureBloc;
  late VideoChatStateModel _videoChatStateModel;

  @override
  void initState() {
    super.initState();
    _videoChatFeatureBloc = widget.videoChatBloc;
    _videoChatStateModel = widget.videoChatBloc.states.value.videoChatStateModel;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: RTCVideoView(
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                _videoChatFeatureBloc
                    .states.value.videoChatStateModel.videoChatEntities.first.videoRenderer!,
              ),
            ),
            const Divider(
              height: 0,
              color: Colors.black12,
            ),
            Expanded(
              child: RTCVideoView(
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                _videoChatFeatureBloc
                    .states.value.videoChatStateModel.currentVideoChatEntity!.videoRenderer!,
                mirror: !_videoChatStateModel.cameraSwitched,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
