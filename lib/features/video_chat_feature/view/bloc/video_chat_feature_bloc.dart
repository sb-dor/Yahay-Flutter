import 'dart:async';
import 'package:camera/camera.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';
import 'package:yahay/features/video_chat_feature/domain/usecases/start_video_chat.dart';
import 'package:yahay/features/video_chat_feature/domain/usecases/video_chat_entrance.dart';
import 'package:yahay/features/video_chat_feature/domain/usecases/leave_video_chat.dart';
import 'package:yahay/features/video_chat_feature/domain/usecases/stream_the_video.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/state_model/video_chat_state_model.dart';
import 'package:yahay/injections/injections.dart';
import 'video_chat_feature_events.dart';
import 'video_chat_feature_states.dart';

@immutable
class VideoChatFeatureBloc {
  // useCases data
  static late StartVideoChat _startVideoChat;
  static late VideoChatEntrance _videoChatEntrance;
  static late LeaveVideoChat _leaveVideoChat;
  static late StreamTheVideo _streamTheVideo;

  //
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
    events.add(const FinishVideoChatEvent());
    events.close();
    _states.value.videoChatStateModel.dispose();
  }

  factory VideoChatFeatureBloc({
    required VideoChatFeatureRepo repo,
  }) {
    // useCases registration
    _startVideoChat = StartVideoChat(repo);
    _videoChatEntrance = VideoChatEntrance(repo);
    _leaveVideoChat = LeaveVideoChat(repo);
    _streamTheVideo = StreamTheVideo(repo);

    //
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
    } else if (event is VideoChatEntranceEvent) {
      yield* _videoChatEntranceEvent(event);
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

    _currentStateModel.initChannelChat(chat);

    _currentStateModel.initCurrentUser(currentUser);

    _currentStateModel.initCurrentVideoChatEntity(
      VideoChatEntity(
        imageData: null,
        chat: _currentStateModel.chat,
        user: _currentStateModel.currentUser,
      ),
    );

    await _currentStateModel.initMainCameraController(
      CameraController(
        _currentStateModel.cameraService.cameras[0],
        ResolutionPreset.low,
      ),
    );

    yield InitialVideoChatState(_currentStateModel);
  }

  //
  static Stream<VideoChatFeatureStates> _startVideoChatEvent(
    StartVideoChatEvent event,
  ) async* {
    if (_currentStateModel.currentVideoChatEntity == null) return;

    // start to loading chat
    yield LoadingVideoChatState(_currentStateModel);

    final resultOfStart = await _startVideoChat.startVideoChat(
      _currentStateModel.currentVideoChatEntity!,
    );

    if (!resultOfStart) return;
    // create only channel subscription
    // after successfully response we will send the data to the server
    _currentStateModel.initPusherChannelClient(
      PusherChannelsClient.websocket(
        options: snoopy<PusherClientService>().options,
        connectionErrorHandler: (f, s, th) {},
      ),
    );

    final channelName = "video_${_currentStateModel.chatFunctions?.channelName()}";

    debugPrint("channel name for video chat: $channelName");

    final channel = _currentStateModel.pusherChannelClient?.publicChannel(
      channelName,
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

    // was just for check
    // you have to call this function after
    // acception video call from the other side
    _currentStateModel.mainVideoStreamCameraController?.startImageStream((cameraImage) async {
      // after specific time sending data
      if (!(_currentStateModel.timerForGettingFrame?.isActive ?? false) ||
          _currentStateModel.timerForGettingFrame == null) {
        // after every 100 millisecond we will send data to user through pusher
        _currentStateModel.initTimer(Timer(const Duration(milliseconds: 100), () async {
          // convert each getting image stream to Uint8List and send to server
          final utf8ListInt = _currentStateModel.cameraService.convertYUV420toImage(cameraImage);
          _sendDataToTheServer(utf8ListInt);
        }));
      }
      // cameraImage.
    });
  }

  // not starting video, this event is for someone who wants to participate to video chat
  static Stream<VideoChatFeatureStates> _videoChatEntranceEvent(
    VideoChatEntranceEvent event,
  ) async* {
    if (_currentStateModel.currentVideoChatEntity == null) return;
    //
    final resultOfJoining = await _videoChatEntrance.videoChatEntrance(
      _currentStateModel.currentVideoChatEntity!,
    );
  }

  //
  static Stream<VideoChatFeatureStates> _finishVideoChatEvent(
    FinishVideoChatEvent event,
  ) async* {
    //
    if (_currentStateModel.currentVideoChatEntity == null) return;
    final result = await _leaveVideoChat.leaveVideoChat(
      _currentStateModel.currentVideoChatEntity!,
    );

  }

  // function that sends image Uint8List to the server
  static void _sendDataToTheServer(Uint8List? imageData) {
    if (imageData == null) return;
  }

  // for handling others video chat data
  static Stream<VideoChatFeatureStates> _videoStreamHandlerEvent(
    VideoStreamHandlerEvent event,
  ) async* {
    // TODO : write a code to get data from server
    yield InitialVideoChatState(_currentStateModel);
  }

  static Stream<VideoChatFeatureStates> _emitter() async* {
    if (_currentState.value is InitialVideoChatState) {
      yield InitialVideoChatState(_currentStateModel);
    } else if (_currentState.value is LoadingVideoChatState) {
      yield LoadingVideoChatState(_currentStateModel);
    } else if (_currentState.value is ErrorVideoChatState) {
      yield ErrorVideoChatState(_currentStateModel);
    }
  }
}
