import 'package:camera/camera.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/video_chat_feature/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/state_model/video_chat_state_model.dart';
import 'package:yahay/injections/injections.dart';
import 'video_chat_feature_events.dart';
import 'video_chat_feature_states.dart';

@immutable
class VideoChatFeatureBloc {
  static late BehaviorSubject<VideoChatFeatureStates> _currentState;
  static late VideoChatStateModel _currentStateModel;

  final Sink<VideoChatFeatureEvents> events;
  final BehaviorSubject<VideoChatFeatureStates> _states;

  BehaviorSubject<VideoChatFeatureStates> get states => _states;

  const VideoChatFeatureBloc._({
    required this.events,
    required BehaviorSubject<VideoChatFeatureStates> states,
  }) : _states = states;

  void dispose() {
    events.close();
    _states.value.videoChatStateModel.dispose();
  }

  factory VideoChatFeatureBloc({
    required VideoChatFeatureRepo repo,
  }) {
    final eventsHandler = BehaviorSubject<VideoChatFeatureEvents>();

    _currentStateModel = VideoChatStateModel();

    final states = eventsHandler.switchMap<VideoChatFeatureStates>((events) async* {
      yield* _eventHandler(events);
    }).startWith(InitialVideoChatState(_currentStateModel));

    final statesHandler = BehaviorSubject<VideoChatFeatureStates>()..addStream(states);

    _currentState = statesHandler;

    return VideoChatFeatureBloc._(
      events: eventsHandler.sink,
      states: statesHandler,
    );
  }

  static Stream<VideoChatFeatureStates> _eventHandler(VideoChatFeatureEvents event) async* {
    if (event is VideoChatInitFeatureEvent) {
      yield* _videoChatInitFeatureEvent(event);
    } else if (event is StartVideoChatEvent) {
      yield* _startVideoChatEvent(event);
    } else if (event is FinishVideoChatEvent) {
      yield* _finishVideoChatEvent(event);
    }
  }

  static Stream<VideoChatFeatureStates> _videoChatInitFeatureEvent(
    VideoChatInitFeatureEvent event,
  ) async* {
    final currentUser = snoopy<AuthBloc>().states.value.authStateModel.user;
    final cameraController = CameraController(
      _currentStateModel.cameraService.cameras[0],
      ResolutionPreset.max,
    );

    _currentStateModel.initChannelName(event.channelName);

    final videoChatEntity = VideoChatEntity(
      user: currentUser,
      cameraController: cameraController,
      chatChannelName: event.channelName,
    );

    _currentStateModel.addVideoChat(videoChatEntity);

    await videoChatEntity.cameraController.initialize();

    // was just for check
    // you have to call this function after
    // acception video call from the other side
    // _cameraListener(videoChatEntity.cameraController);

    yield InitialVideoChatState(_currentStateModel);
  }

  //
  static Stream<VideoChatFeatureStates> _startVideoChatEvent(
    StartVideoChatEvent event,
  ) async* {
    // create only channel subscription
    // after successfully response we will send the data to the server
    _currentStateModel.initPusherChannelClient(
      PusherChannelsClient.websocket(
        options: snoopy<PusherClientService>().options,
        connectionErrorHandler: (f, s, th) {},
      ),
    );

    final channel = _currentStateModel.pusherChannelClient?.publicChannel(
      "video_${_currentStateModel.channelName}",
    );

    final channelSubs = _currentStateModel.pusherChannelClient?.onConnectionEstablished.listen(
      (e) {
        channel?.subscribeIfNotUnsubscribed();
      },
    );

    _currentStateModel.initChannelSubscription(channelSubs);

    await _currentStateModel.pusherChannelClient?.connect();

    channel?.bind(Constants.chatVideoStreamEventName).listen((pusherEvent) {
      // TODO: handle event data by creating bloc event
    });
  }

  //
  static Stream<VideoChatFeatureStates> _finishVideoChatEvent(
    FinishVideoChatEvent event,
  ) async* {
    //
  }

  static void _cameraListener(CameraController controller) {
    controller.startImageStream((cameraImage) {
      final utf8ListInt = _currentStateModel.cameraService.convertImageToJpeg(cameraImage);
      debugPrint("utf 8 list data is: $utf8ListInt");
    });
  }
}
