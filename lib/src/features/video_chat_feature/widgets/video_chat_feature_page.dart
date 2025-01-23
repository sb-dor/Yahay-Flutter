import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/video_chat_bloc_factory.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_events.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_states.dart';

import 'type_of_screens/double_camera_view_screen.dart';
import 'type_of_screens/multiple_camera_view.dart';
import 'type_of_screens/single_camera_view_screen.dart';
import 'widgets/call_button_widget.dart';
import 'widgets/hang_up_buttons_widget.dart';

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
    final depContainer = DependenciesScope.of(context, listen: false);
    _videoChatFeatureBloc = VideoChatBlocFactory(
      depContainer.authBloc.state.authStateModel.user,
      depContainer.pusherClientService,
    ).create();
    _videoChatFeatureBloc.events.add(VideoChatInitFeatureEvent(
      widget.chat,
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
              if (currentStateModel.currentVideoChatEntity?.videoRenderer == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Stack(
                  children: [
                    if (currentStateModel.videoChatEntities.isEmpty)
                      SingleCameraViewScreen(
                        videoChatBloc: _videoChatFeatureBloc,
                      )
                    else if (currentStateModel.videoChatEntities.length == 1)
                      DoubleCameraViewScreen(videoChatBloc: _videoChatFeatureBloc)
                    else if (currentStateModel.videoChatEntities.length > 1)
                      const MultipleCameraView(),
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: currentStateModel.chatStarted
                            ? HangUpButtonsWidget(videoChatBloc: _videoChatFeatureBloc)
                            : CallButtonWidget(
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
