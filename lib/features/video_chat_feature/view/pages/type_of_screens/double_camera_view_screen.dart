import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    _videoChatFeatureBloc = widget.videoChatBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Image.memory(
                gaplessPlayback: true,
                fit: BoxFit.contain,
                _videoChatFeatureBloc
                    .states.value.videoChatStateModel.videoChatEntities.first.imageData!,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: CameraPreview(
                _videoChatFeatureBloc
                    .states.value.videoChatStateModel.mainVideoStreamCameraController!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
