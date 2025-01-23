import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/features/video_chat_feature/widgets/bloc/state_model/video_chat_state_model.dart';
import 'package:yahay/src/features/video_chat_feature/widgets/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/src/features/video_chat_feature/widgets/bloc/video_chat_feature_events.dart';

class HangUpButtonsWidget extends StatefulWidget {
  final VideoChatFeatureBloc videoChatBloc;

  const HangUpButtonsWidget({
    super.key,
    required this.videoChatBloc,
  });

  @override
  State<HangUpButtonsWidget> createState() => _HangUpButtonsWidgetState();
}

class _HangUpButtonsWidgetState extends State<HangUpButtonsWidget> {
  late final VideoChatFeatureBloc _videoChatFeatureBloc;
  late final VideoChatStateModel _videoChatStateModel;

  @override
  void initState() {
    super.initState();
    _videoChatFeatureBloc = widget.videoChatBloc;
    _videoChatStateModel = _videoChatFeatureBloc.states.value.videoChatStateModel;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () async {
              _videoChatFeatureBloc.events.add(SwitchCameraStreamEvent());
            },
            child: const SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: Icon(
                  CupertinoIcons.switch_camera,
                  size: 35,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Material(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              _videoChatFeatureBloc.events.add(TurnCameraOffAndEvent());
            },
            child: Stack(
              children: [
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Icon(
                      CupertinoIcons.video_camera,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (!_videoChatStateModel.hasVideo)
                  const Positioned.fill(
                    child: Center(
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(45 / 360),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Material(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              _videoChatFeatureBloc.events.add(const TurnMicOffAndOnEvent());
            },
            child: SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: Icon(
                  _videoChatStateModel.hasAudio ? CupertinoIcons.mic : CupertinoIcons.mic_off,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Material(
          color: Colors.red,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              if (_videoChatFeatureBloc.states.value.videoChatStateModel.chatStarted) {
                // when you dispose main stream page
                // it automatically finishes the chat.
                // I wrote dispose code in main screen's dispose method
                Navigator.pop(context);
              }
            },
            child: const SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: Icon(
                  CupertinoIcons.phone_down,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
