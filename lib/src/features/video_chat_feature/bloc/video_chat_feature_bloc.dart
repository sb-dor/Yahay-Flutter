import 'dart:async';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/src/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/src/features/video_chat_feature/domain/repo/video_chat_feature_repo.dart';

import 'state_model/video_chat_state_model.dart';

part 'video_chat_feature_bloc.freezed.dart';

@immutable
@freezed
class VideoChatFeatureEvents with _$VideoChatFeatureEvents {
  const factory VideoChatFeatureEvents.videoChatInitFeatureEvent(final ChatModel? chat) =
      _VideoChatInitFeatureEvent;

  const factory VideoChatFeatureEvents.startVideoChatEvent() = _StartVideoChatEvent;

  const factory VideoChatFeatureEvents.videoChatEntranceEvent() = _VideoChatEntranceEvent;

  const factory VideoChatFeatureEvents.finishVideoChatEvent({
    required void Function() popScreen,
  }) = _FinishVideoChatEvent;

  const factory VideoChatFeatureEvents.onAddRemoteRendererStreamEvent(
      final MediaStream mediaStream) = _OnAddRemoteRendererStreamEvent;

  const factory VideoChatFeatureEvents.switchCameraStreamEvent() = _SwitchCameraStreamEvent;

  const factory VideoChatFeatureEvents.turnMicOffAndOnEvent({@Default(true) final bool change}) =
      _TurnMicOffAndOnEvent;

  const factory VideoChatFeatureEvents.turnCameraOffAndEvent() = _TurnCameraOffAndEvent;
}

// @immutable
// class InitMainCameraControllerEvent extends VideoChatFeatureEvents {
//   final CameraDescription cameraDescription;
//
//   const InitMainCameraControllerEvent(this.cameraDescription);
// }

// @immutable
// class VideoStreamHandlerEvent extends VideoChatFeatureEvents {
//   final ChannelReadEvent? pusherEvent;
//
//   const VideoStreamHandlerEvent(this.pusherEvent);
// }

@immutable
@freezed
class VideoChatFeatureStates with _$VideoChatFeatureStates {
  const factory VideoChatFeatureStates.initialVideoChatState(
      final VideoChatStateModel videoChatStateModel) = _InitialVideoChatState;
}

class VideoChatBloc extends Bloc<VideoChatFeatureEvents, VideoChatFeatureStates> {
  StreamSubscription<void>? _channelSubscription;
  PusherChannelsClient? _pusherChannelsClient;

  final VideoChatFeatureRepo _iVideoChatFeatureRepo;
  final UserModel? _currentUser;
  final PusherClientService _pusherClientService;
  late final VideoChatStateModel _currentStateModel;

  VideoChatBloc({
    required VideoChatFeatureRepo iVideoChatFeatureRepo,
    required UserModel? currentUser,
    required PusherClientService pusherClientService,
    required VideoChatFeatureStates initialState,
  })  : _iVideoChatFeatureRepo = iVideoChatFeatureRepo,
        _currentUser = currentUser,
        _pusherClientService = pusherClientService,
        super(initialState) {
    _currentStateModel = initialState.videoChatStateModel;
    //

    on<VideoChatFeatureEvents>(
      (event, emit) => event.map(
        videoChatInitFeatureEvent: (event) => _videoChatInitFeatureEvent(event, emit),
        startVideoChatEvent: (event) => _startVideoChatEvent(event, emit),
        videoChatEntranceEvent: (event) => _videoChatEntranceEvent(event, emit),
        finishVideoChatEvent: (event) => _finishVideoChatEvent(event, emit),
        onAddRemoteRendererStreamEvent: (event) => _onAddRemoteRendererStreamEvent(event, emit),
        switchCameraStreamEvent: (event) => _switchCameraStreamEvent(event, emit),
        turnMicOffAndOnEvent: (event) => _turnMicOffAndOnEvent(event, emit),
        turnCameraOffAndEvent: (event) => _turnCameraOffAndEvent(event, emit),
      ),
    );
  }

  void _videoChatInitFeatureEvent(
    _VideoChatInitFeatureEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    final chat = event.chat;

    if (chat == null) return;

    _currentStateModel.initChannelChat(chat);

    _currentStateModel.initCurrentUser(_currentUser);

    await _currentStateModel.initLocalRenderer(_pusherClientService);

    // in order to listen that someone from other side connected to your data
    _currentStateModel.webrtcLaravelHelper?.onAddRemoteStream = ((stream) async {
      add(VideoChatFeatureEvents.onAddRemoteRendererStreamEvent(stream));
    });

    emit(VideoChatFeatureStates.initialVideoChatState(_currentStateModel));
  }

  void _startVideoChatEvent(
    _StartVideoChatEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    if (_currentStateModel.currentVideoChatEntity == null) return;

    final initResponse = await _initVideoPusher();

    if (!initResponse) return;

    final roomId = await _currentStateModel.webrtcLaravelHelper?.createRoom(
      _currentStateModel.chat,
    );

    debugPrint("creating room id: $roomId");
    // -------------------------------------------------

    emit(VideoChatFeatureStates.initialVideoChatState(_currentStateModel));

    // was just for check
    // you have to call this function after
    // acception video call from the other side
    // _currentStateModel.mainVideoStreamCameraController?.startImageStream(
    //   (cameraImage) async {
    //     // after specific time sending data
    //     if (!(_currentStateModel.timerForGettingFrame?.isActive ?? false) ||
    //         _currentStateModel.timerForGettingFrame == null) {
    //       // after every 100 millisecond we will send data to user through pusher
    //
    //       _currentStateModel.initTimer(
    //         Timer(
    //           const Duration(milliseconds: 100),
    //           () async {
    //             // convert each getting image stream to Uint8List and send to server
    //             final frontCamera =
    //                 _currentStateModel.mainVideoStreamCameraController?.description ==
    //                     _currentStateModel.cameraService.cameras.first;
    //             final utf8ListInt = _currentStateModel.cameraService.convertYUV420toImage(
    //               cameraImage,
    //               frontCamera: frontCamera,
    //             );
    //             _sendDataToTheServer(utf8ListInt);
    //           },
    //         ),
    //       );
    //     }
    //     // cameraImage.
    //   },
    // );

    // audio stream sender
    // make this singleton
    // await _currentStateModel.flutterSound?.thePlayer.openPlayer();

    // await _currentStateModel.flutterSound?.thePlayer.startPlayerFromStream(
    //   codec: Codec.pcm16,
    //   numChannels: 1,
    //   sampleRate: 44100,
    // );
    // Stream<List<int>> stream = MicStream.microphone(sampleRate: 44100);
    //
    // StreamSubscription<List<int>> listener = stream.listen((data){
    //   _micDataHandler(Uint8List.fromList(data));
    // });
    //
    // _currentStateModel.initAudioStreamSubscription(listener);
  }

  void _videoChatEntranceEvent(
    _VideoChatEntranceEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    //
    final room = _currentStateModel.chat?.videoChatRoom;

    if (room == null) return;

    final resultOfJoining = await _iVideoChatFeatureRepo.videoChatEntrance(
      _currentStateModel.currentVideoChatEntity!,
    );

    _currentStateModel.startChat();

    await _currentStateModel.webrtcLaravelHelper?.joinRoom(
      room.id.toString(),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      add(const VideoChatFeatureEvents.turnMicOffAndOnEvent(change: false));
    });

    debugPrint("chat started or not: ${_currentStateModel.chatStarted}");

    emit(VideoChatFeatureStates.initialVideoChatState(_currentStateModel));
  }

  void _finishVideoChatEvent(
    _FinishVideoChatEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    //
    if (_currentStateModel.currentVideoChatEntity == null) return;

    final result = await _iVideoChatFeatureRepo.leaveTheChat(
      _currentStateModel.currentVideoChatEntity!,
    );

    debugPrint("leave video chat data: $result");

    await _currentStateModel.webrtcLaravelHelper?.hangUp(
      _currentStateModel.currentVideoChatEntity?.videoRenderer,
    );

    await _currentStateModel.dispose();

    event.popScreen();
  }

  void _onAddRemoteRendererStreamEvent(
    _OnAddRemoteRendererStreamEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    try {
      debugPrint("coming somebody");
      final videoChatEntity = VideoChatEntity(
        videoRenderer: RTCVideoRenderer(),
        chat: _currentStateModel.chat,
        user: null,
      );
      await videoChatEntity.videoRenderer?.initialize();
      // videoChatEntity.videoRenderer?.srcObject =
      //     await createLocalMediaStream('key${Random().nextInt(100)}');
      videoChatEntity.videoRenderer?.srcObject = event.mediaStream;
      _currentStateModel.addVideoChat(videoChatEntity);

      emit(VideoChatFeatureStates.initialVideoChatState(_currentStateModel));
    } catch (error, stackTrace) {
      debugPrint("getting error in stream handler: $error");
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _switchCameraStreamEvent(
    _SwitchCameraStreamEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    _currentStateModel.switchCamera();

    Helper.switchCamera(
      _currentStateModel.currentVideoChatEntity!.videoRenderer!.srcObject!.getVideoTracks()[0],
      null,
      _currentStateModel.webrtcLaravelHelper?.localStream,
    );

    emit(VideoChatFeatureStates.initialVideoChatState(_currentStateModel));
  }

  void _turnMicOffAndOnEvent(
    _TurnMicOffAndOnEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    if (event.change) _currentStateModel.changeHasAudio();

    Helper.setMicrophoneMute(
      !_currentStateModel.hasAudio,
      _currentStateModel.currentVideoChatEntity!.videoRenderer!.srcObject!.getAudioTracks()[0],
    );

    emit(VideoChatFeatureStates.initialVideoChatState(_currentStateModel));
  }

  void _turnCameraOffAndEvent(
    _TurnCameraOffAndEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    _currentStateModel.changeHasVideo();

    final videoTrack =
        _currentStateModel.currentVideoChatEntity!.videoRenderer!.srcObject!.getVideoTracks()[0];

    videoTrack.enabled = _currentStateModel.hasVideo;

    emit(VideoChatFeatureStates.initialVideoChatState(_currentStateModel));
  }

  Future<bool> _initVideoPusher() async {
    final resultOfStart = await _iVideoChatFeatureRepo.startVideoChat(
      _currentStateModel.currentVideoChatEntity!,
    );

    if (!resultOfStart) return false;

    _currentStateModel.startChat();

    return true;
    // create only channel subscription
    // after successfully response we will send the data to the server
    // _currentStateModel.initPusherChannelClient(
    //   PusherChannelsClient.websocket(
    //     options: snoopy<PusherClientService>().options,
    //     connectionErrorHandler: (f, s, th) {},
    //   ),
    // );
    //
    // final channelName = "video_${_currentStateModel.chatFunctions?.channelName()}";
    //
    // debugPrint("channel name for video chat: $channelName");
    //
    // final channel = _currentStateModel.pusherChannelClient?.publicChannel(
    //   channelName,
    // );
    //
    // final channelSubs = _currentStateModel.pusherChannelClient?.onConnectionEstablished.listen(
    //   (e) {
    //     channel?.subscribeIfNotUnsubscribed();
    //   },
    // );
    //
    // _currentStateModel.initChannelSubscription(channelSubs);
    //
    // await _currentStateModel.pusherChannelClient?.connect();
    //
    // channel?.bind(Constants.chatVideoStreamEventName).listen((pusherEvent) {
    //   // TODO: handle event data by creating bloc event
    //   _events.add(VideoStreamHandlerEvent(pusherEvent));
    // });
  }

  @override
  Future<void> close() async {
    await _pusherChannelsClient?.disconnect();
    _pusherChannelsClient?.dispose();
    _channelSubscription?.cancel();
    _currentStateModel.dispose();
    return super.close();
  }
}
