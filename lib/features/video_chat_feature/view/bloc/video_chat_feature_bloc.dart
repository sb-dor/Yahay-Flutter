import 'dart:async';

import 'package:camera/camera.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/state_model/video_chat_state_model.dart';
import 'package:yahay/injections/injections.dart';
import 'video_chat_feature_events.dart';
import 'video_chat_feature_states.dart';

@immutable
class VideoChatFeatureBloc {
  // in order to use in emitter function
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
    } else if (event is VideoStreamHandlerEvent) {
      yield* _videoStreamHandlerEvent(event);
    }
  }

  static Stream<VideoChatFeatureStates> _videoChatInitFeatureEvent(
    VideoChatInitFeatureEvent event,
  ) async* {
    final chat = event.chat;
    if (chat == null) return;
    final currentUser = snoopy<AuthBloc>().states.value.authStateModel.user;
    final cameraController = CameraController(
      _currentStateModel.cameraService.cameras[0],
      ResolutionPreset.low,
    );

    _currentStateModel.initChannelName(chat);

    final videoChatEntity = VideoChatEntity(
      user: currentUser,
      cameraController: cameraController,
      chat: chat,
    );

    _currentStateModel.addVideoChat(videoChatEntity);

    await videoChatEntity.cameraController.initialize();

    // was just for check
    // you have to call this function after
    // acception video call from the other side
    _currentStateModel.currentVideoChat?.cameraController.startImageStream((cameraImage) async {
      // after specific time sending data
      if (!(_currentStateModel.timerForGettingFrame?.isActive ?? false) ||
          _currentStateModel.timerForGettingFrame == null) {
        _currentStateModel.initTimer(Timer(const Duration(milliseconds: 100), () async {
          final utf8ListInt = _currentStateModel.cameraService.convertYUV420toImage(cameraImage);
          event.deleteThen?.add(VideoStreamHandlerEvent(null, deleteThen: utf8ListInt));
        }));
      }
      // cameraImage.
    });

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
      event.events.add(VideoStreamHandlerEvent(pusherEvent));
    });

    // you have to use controller here

    // controller.startImageStream((cameraImage) {
    //   final utf8ListInt = _currentStateModel.cameraService.convertImageToJpeg(cameraImage);
    //   _currentStateModel.addToUInt8List(utf8ListInt);
    // });
  }

  //
  static Stream<VideoChatFeatureStates> _finishVideoChatEvent(
    FinishVideoChatEvent event,
  ) async* {
    //
  }

  static Stream<VideoChatFeatureStates> _videoStreamHandlerEvent(
    VideoStreamHandlerEvent event,
  ) async* {
    // delete this logic. its just for check
    _currentStateModel.addToUInt8List(event.deleteThen!);
    debugPrint("urfdata: ${_currentStateModel.uInt8Image?.length}");
    yield InitialVideoChatState(_currentStateModel);
  }
}
