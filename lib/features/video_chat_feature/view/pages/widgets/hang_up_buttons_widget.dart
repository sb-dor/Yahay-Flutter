import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/state_model/video_chat_state_model.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';

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
          color: Colors.grey,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () async {
            },
            child: const SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: Icon(
                  CupertinoIcons.switch_camera,
                  size: 35,
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
