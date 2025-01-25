import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/video_chat_bloc_factory.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';
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
  late final VideoChatBloc _videoChatFeatureBloc;

  @override
  void initState() {
    super.initState();
    final depContainer = DependenciesScope.of(context, listen: false);
    _videoChatFeatureBloc = VideoChatBlocFactory(
      depContainer.authBloc.state.authStateModel.user,
      depContainer.pusherClientService,
    ).create();
    _videoChatFeatureBloc.add(VideoChatFeatureEvents.videoChatInitFeatureEvent(
      widget.chat,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VideoChatBloc, VideoChatFeatureStates>(
        bloc: _videoChatFeatureBloc,
        builder: (context, state) {
          final currentStateModel = state.videoChatStateModel;
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
        },
      ),
    );
  }
}
