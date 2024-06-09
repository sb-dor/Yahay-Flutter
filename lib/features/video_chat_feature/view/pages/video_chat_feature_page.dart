import 'package:auto_route/annotations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_events.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_states.dart';
import 'package:yahay/injections/injections.dart';

import 'widgets/call_button_widget.dart';

@RoutePage()
class VideoChatFeaturePage extends StatefulWidget {
  final String channelName;

  const VideoChatFeaturePage({
    super.key,
    required this.channelName,
  });

  @override
  State<VideoChatFeaturePage> createState() => _VideoChatFeaturePageState();
}

class _VideoChatFeaturePageState extends State<VideoChatFeaturePage> {
  late final VideoChatFeatureBloc _videoChatFeatureBloc;

  @override
  void initState() {
    super.initState();
    _videoChatFeatureBloc = snoopy<VideoChatFeatureBloc>();
    _videoChatFeatureBloc.events.add(VideoChatInitFeatureEvent(widget.channelName));
  }

  @override
  void dispose() {
    _videoChatFeatureBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<VideoChatFeatureStates>(
        stream: _videoChatFeatureBloc.states,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final currentState = snapshot.requireData;
              final currentStateModel = currentState.videoChatStateModel;
              if (!(currentStateModel.currentVideoChat?.cameraController.value.isInitialized ??
                      false) ||
                  currentStateModel.currentVideoChat?.cameraController == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: CameraPreview(currentStateModel.currentVideoChat!.cameraController),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CallButtonWidget(
                          videoChatBloc: _videoChatFeatureBloc,
                        ),
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
