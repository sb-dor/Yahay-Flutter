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
import 'package:yahay/src/features/video_chat_feature/webrtc_service/webrtc_laravel_service.dart';
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
  WebrtcLaravelService? _webrtcLaravelHelper;

  final VideoChatFeatureRepo _iVideoChatFeatureRepo;
  final UserModel? _currentUser;
  final PusherClientService _pusherClientService;

  VideoChatBloc({
    required VideoChatFeatureRepo iVideoChatFeatureRepo,
    required UserModel? currentUser,
    required PusherClientService pusherClientService,
    required VideoChatFeatureStates initialState,
  })  : _iVideoChatFeatureRepo = iVideoChatFeatureRepo,
        _currentUser = currentUser,
        _pusherClientService = pusherClientService,
        super(initialState) {
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

    var currentStateModel = state.videoChatStateModel.copyWith(
      chat: chat.copyWith(),
      currentUser: _currentUser,
    );

    emit(VideoChatFeatureStates.initialVideoChatState(currentStateModel));

    await _initLocalRenderer(_pusherClientService);
    // in order to listen that someone from other side connected to your data
    _webrtcLaravelHelper?.onAddRemoteStream = ((stream) async {
      add(VideoChatFeatureEvents.onAddRemoteRendererStreamEvent(stream));
    });

    emit(VideoChatFeatureStates.initialVideoChatState(currentStateModel));
  }

  void _startVideoChatEvent(
    _StartVideoChatEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    if (state.videoChatStateModel.currentVideoChatEntity == null) return;

    final initResponse = await _initVideoPusher(emit);

    if (!initResponse) return;

    final roomId = await _webrtcLaravelHelper?.createRoom(
      state.videoChatStateModel.chat,
    );

    debugPrint("creating room id: $roomId");
    // -------------------------------------------------

    emit(VideoChatFeatureStates.initialVideoChatState(state.videoChatStateModel));
  }

  void _videoChatEntranceEvent(
    _VideoChatEntranceEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    //
    final room = state.videoChatStateModel.chat?.videoChatRoom;

    if (room == null) return;

    final resultOfJoining = await _iVideoChatFeatureRepo.videoChatEntrance(
      state.videoChatStateModel.currentVideoChatEntity!,
    );

    var currentStateModel = state.videoChatStateModel.copyWith(
      chatStarted: resultOfJoining,
    );

    await _webrtcLaravelHelper?.joinRoom(
      room.id.toString(),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      add(const VideoChatFeatureEvents.turnMicOffAndOnEvent(change: false));
    });

    debugPrint("chat started or not: ${currentStateModel.chatStarted}");

    emit(VideoChatFeatureStates.initialVideoChatState(currentStateModel));
  }

  void _finishVideoChatEvent(
    _FinishVideoChatEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    //
    if (state.videoChatStateModel.currentVideoChatEntity == null) return;

    final result = await _iVideoChatFeatureRepo.leaveTheChat(
      state.videoChatStateModel.currentVideoChatEntity!,
    );

    debugPrint("leave video chat data: $result");

    await _webrtcLaravelHelper?.hangUp(
      state.videoChatStateModel.currentVideoChatEntity?.videoRenderer,
    );

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
        chat: state.videoChatStateModel.chat,
        user: null,
      );
      await videoChatEntity.videoRenderer?.initialize();
      // videoChatEntity.videoRenderer?.srcObject =
      //     await createLocalMediaStream('key${Random().nextInt(100)}');
      videoChatEntity.videoRenderer?.srcObject = event.mediaStream;

      final currentChatEntities = List.of(state.videoChatStateModel.videoChatEntities);

      currentChatEntities.add(videoChatEntity);

      var currentStateModel = state.videoChatStateModel.copyWith(
        videoChatEntities: currentChatEntities,
      );

      emit(VideoChatFeatureStates.initialVideoChatState(currentStateModel));
    } catch (error, stackTrace) {
      debugPrint("getting error in stream handler: $error");
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _switchCameraStreamEvent(
    _SwitchCameraStreamEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    var currentStateModel = state.videoChatStateModel.copyWith(
      cameraSwitched: !state.videoChatStateModel.cameraSwitched,
    );

    Helper.switchCamera(
      currentStateModel.currentVideoChatEntity!.videoRenderer!.srcObject!.getVideoTracks()[0],
      null,
      _webrtcLaravelHelper?.localStream,
    );

    emit(VideoChatFeatureStates.initialVideoChatState(currentStateModel));
  }

  void _turnMicOffAndOnEvent(
    _TurnMicOffAndOnEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    var currentStateModel = state.videoChatStateModel;

    if (event.change) {
      currentStateModel = currentStateModel.copyWith(
        hasAudio: !currentStateModel.hasAudio,
      );
    }

    Helper.setMicrophoneMute(
      !currentStateModel.hasAudio,
      currentStateModel.currentVideoChatEntity!.videoRenderer!.srcObject!.getAudioTracks()[0],
    );

    emit(VideoChatFeatureStates.initialVideoChatState(currentStateModel));
  }

  void _turnCameraOffAndEvent(
    _TurnCameraOffAndEvent event,
    Emitter<VideoChatFeatureStates> emit,
  ) async {
    var currentStateModel = state.videoChatStateModel.copyWith(
      hasVideo: !state.videoChatStateModel.hasVideo,
    );

    final videoTrack =
        currentStateModel.currentVideoChatEntity!.videoRenderer!.srcObject!.getVideoTracks()[0];

    videoTrack.enabled = currentStateModel.hasVideo;

    emit(VideoChatFeatureStates.initialVideoChatState(currentStateModel));
  }

  Future<bool> _initVideoPusher(Emitter<VideoChatFeatureStates> emit) async {
    final resultOfStart = await _iVideoChatFeatureRepo.startVideoChat(
      state.videoChatStateModel.currentVideoChatEntity!,
    );

    if (!resultOfStart) return false;

    var currentStateModel = state.videoChatStateModel.copyWith(
      chatStarted: true,
    );

    emit(VideoChatFeatureStates.initialVideoChatState(currentStateModel));

    return true;
  }

  Future<void> _initLocalRenderer(PusherClientService pusherClientService) async {
    // helper initialization first
    _webrtcLaravelHelper = WebrtcLaravelService(pusherClientService);

    final currentVideoChatEntity = VideoChatEntity(
      videoRenderer: RTCVideoRenderer(),
      chat: state.videoChatStateModel.chat,
      user: _currentUser,
    );

    // init the video renderer
    await currentVideoChatEntity.videoRenderer?.initialize();

    // after video render initialization open the media
    await _webrtcLaravelHelper?.openUserMedia(currentVideoChatEntity.videoRenderer!);
  }

  @override
  Future<void> close() async {
    await _pusherChannelsClient?.disconnect();
    _pusherChannelsClient?.dispose();
    _channelSubscription?.cancel();
    state.videoChatStateModel.dispose();
    if (state.videoChatStateModel.currentVideoChatEntity?.videoRenderer != null) {
      await _webrtcLaravelHelper?.hangUp(
        state.videoChatStateModel.currentVideoChatEntity!.videoRenderer!,
      );
    }
    return super.close();
  }
}
