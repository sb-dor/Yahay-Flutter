import 'package:auto_route/annotations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_events.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_states.dart';
import 'package:yahay/injections/injections.dart';

import 'widgets/call_button_widget.dart';

@RoutePage()
class VideoChatFeaturePage extends StatefulWidget {
  final Chat? chat;

  const VideoChatFeaturePage({
    super.key,
    required this.chat,
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
    _videoChatFeatureBloc.events.add(VideoChatInitFeatureEvent(
      widget.chat,
      deleteThen: _videoChatFeatureBloc.events,
    ));
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
                      child: Container(
                        color: Colors.black,
                      ),
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
                    if (currentStateModel.uInt8List != null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Image.memory(currentStateModel.uInt8List!),
                        ),
                      )
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
