import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/video_chat_bloc_factory.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';
import 'type_of_screens/double_camera_view_screen.dart';
import 'type_of_screens/multiple_camera_view.dart';
import 'type_of_screens/single_camera_view_screen.dart';
import 'widgets/call_button_widget.dart';
import 'widgets/hang_up_buttons_widget.dart';

@RoutePage()
class VideoChatFeaturePage extends StatelessWidget {
  final ChatModel? chat;

  const VideoChatFeaturePage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final depContainer = DependenciesScope.of(context, listen: false);
    return BlocProvider(
      create:
          (_) =>
              VideoChatBlocFactory(
                user: depContainer.authBloc.state.authStateModel.user,
                pusherClientService: depContainer.pusherClientService,
                logger: depContainer.logger,
                restClientBase: depContainer.restClientBase,
              ).create(),
      child: _VideoChatFeaturePageUI(chat: chat),
    );
  }
}

class _VideoChatFeaturePageUI extends StatefulWidget {
  final ChatModel? chat;

  const _VideoChatFeaturePageUI({required this.chat});

  @override
  State<_VideoChatFeaturePageUI> createState() =>
      _VideoChatFeaturePageUIState();
}

class _VideoChatFeaturePageUIState extends State<_VideoChatFeaturePageUI> {
  @override
  void initState() {
    super.initState();
    context.read<VideoChatBloc>().add(
      VideoChatFeatureEvents.videoChatInitFeatureEvent(widget.chat),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VideoChatBloc, VideoChatFeatureStates>(
        builder: (context, state) {
          final currentStateModel = state.videoChatStateModel;
          if (currentStateModel.currentVideoChatEntity?.videoRenderer == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                if (currentStateModel.videoChatEntities.isEmpty)
                  const SingleCameraViewScreen()
                else if (currentStateModel.videoChatEntities.length == 1)
                  const DoubleCameraViewScreen()
                else if (currentStateModel.videoChatEntities.length > 1)
                  const MultipleCameraView(),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child:
                        currentStateModel.chatStarted
                            ? const HangUpButtonsWidget()
                            : const CallButtonWidget(),
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
