import 'package:flutter/material.dart';
import 'package:yahay/features/video_chat_feature/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_events.dart';
import 'package:yahay/injections/injections.dart';

class CallButtonWidget extends StatefulWidget {
  final VideoChatFeatureBloc videoChatBloc;

  const CallButtonWidget({
    super.key,
    required this.videoChatBloc,
  });

  @override
  State<CallButtonWidget> createState() => _CallButtonWidgetState();
}

class _CallButtonWidgetState extends State<CallButtonWidget> {
  late final VideoChatFeatureBloc _videoChatFeatureBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoChatFeatureBloc = widget.videoChatBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Material(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () async {
              final cameras = snoopy<CameraHelperService>().cameras;
              // for (var each in desc) {
              //   debugPrint("camera name: ${each.name}");
              // }
              if (cameras.length >= 2) {
                final controller = _videoChatFeatureBloc
                    .states.value.videoChatStateModel.mainVideoStreamCameraController;
                if (controller?.description.name == cameras.last.name) {
                  _videoChatFeatureBloc.events.add(InitMainCameraControllerEvent(
                    cameras.first,
                  ));
                } else {
                  _videoChatFeatureBloc.events.add(InitMainCameraControllerEvent(
                    cameras.last,
                  ));
                }
              }
            },
            child: const SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: Icon(
                  Icons.cameraswitch,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
        Material(
          color: _videoChatFeatureBloc.states.value.videoChatStateModel.chatStarted
              ? Colors.red
              : Colors.green,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              if (_videoChatFeatureBloc.states.value.videoChatStateModel.chatStarted) {
                // when you dispose main stream page
                // it automatically finishes the chat.
                // I wrote dispose code in main screen's dispose method
                Navigator.pop(context);
              } else {
                _videoChatFeatureBloc.events.add(const StartVideoChatEvent());
              }
            },
            child: const SizedBox(
              width: 90,
              height: 90,
              child: Center(
                child: Icon(
                  Icons.call,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
        Material(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {},
            child: const SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: Icon(Icons.call),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
