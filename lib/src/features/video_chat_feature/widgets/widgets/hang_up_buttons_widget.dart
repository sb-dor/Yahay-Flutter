import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';

class HangUpButtonsWidget extends StatefulWidget {
  const HangUpButtonsWidget({super.key});

  @override
  State<HangUpButtonsWidget> createState() => _HangUpButtonsWidgetState();
}

class _HangUpButtonsWidgetState extends State<HangUpButtonsWidget> {
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
              context.read<VideoChatBloc>().add(
                const VideoChatFeatureEvents.switchCameraStreamEvent(),
              );
            },
            child: const SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: Icon(CupertinoIcons.switch_camera, size: 35, color: Colors.black),
              ),
            ),
          ),
        ),
        BlocBuilder<VideoChatBloc, VideoChatFeatureStates>(
          builder: (context, state) {
            return Material(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  context.read<VideoChatBloc>().add(
                    const VideoChatFeatureEvents.turnCameraOffAndEvent(),
                  );
                },
                child: Stack(
                  children: [
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                        child: Icon(CupertinoIcons.video_camera, size: 35, color: Colors.white),
                      ),
                    ),
                    if (!state.videoChatStateModel.hasVideo)
                      const Positioned.fill(
                        child: Center(
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(45 / 360),
                            child: Icon(Icons.remove, color: Colors.white, size: 60),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        BlocBuilder<VideoChatBloc, VideoChatFeatureStates>(
          builder: (context, state) {
            return Material(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  context.read<VideoChatBloc>().add(
                    const VideoChatFeatureEvents.turnMicOffAndOnEvent(),
                  );
                },
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Icon(
                      state.videoChatStateModel.hasAudio
                          ? CupertinoIcons.mic
                          : CupertinoIcons.mic_off,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        BlocBuilder<VideoChatBloc, VideoChatFeatureStates>(
          builder: (context, state) {
            return Material(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  if (state.videoChatStateModel.chatStarted) {
                    // when you dispose main stream page
                    // it automatically finishes the chat.
                    // I wrote dispose code in main screen's dispose method
                    context.read<VideoChatBloc>().add(
                      VideoChatFeatureEvents.finishVideoChatEvent(
                        popScreen: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }
                },
                child: const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Icon(CupertinoIcons.phone_down, size: 35, color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
