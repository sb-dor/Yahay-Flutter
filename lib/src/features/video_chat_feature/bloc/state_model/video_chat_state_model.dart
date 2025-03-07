import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/features/video_chat_feature/models/video_chat_model.dart';

class VideoChatStateModel {
  //
  const VideoChatStateModel({
    required this.chatStarted,
    required this.hasAudio,
    required this.hasVideo,
    required this.cameraSwitched,
    required this.videoChatEntities,
    this.chat,
    this.currentUser,
    this.currentVideoChatEntity,
  });

  final bool chatStarted;

  final bool hasAudio;

  final bool hasVideo;

  final bool cameraSwitched;

  final ChatModel? chat;

  final UserModel? currentUser;

  final VideoChatModel? currentVideoChatEntity;

  final List<VideoChatModel> videoChatEntities;

  factory VideoChatStateModel.idle() => const VideoChatStateModel(
    chatStarted: false,
    hasAudio: true,
    hasVideo: true,
    cameraSwitched: false,
    currentVideoChatEntity: null,
    videoChatEntities: <VideoChatModel>[],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoChatStateModel &&
          runtimeType == other.runtimeType &&
          chatStarted == other.chatStarted &&
          hasAudio == other.hasAudio &&
          hasVideo == other.hasVideo &&
          cameraSwitched == other.cameraSwitched &&
          chat == other.chat &&
          currentUser == other.currentUser &&
          currentVideoChatEntity == other.currentVideoChatEntity &&
          videoChatEntities == other.videoChatEntities);

  @override
  int get hashCode =>
      chatStarted.hashCode ^
      hasAudio.hashCode ^
      hasVideo.hashCode ^
      cameraSwitched.hashCode ^
      chat.hashCode ^
      currentUser.hashCode ^
      currentVideoChatEntity.hashCode ^
      videoChatEntities.hashCode;

  @override
  String toString() {
    return 'VideoChatStateModel{'
        ' chatStarted: $chatStarted,'
        ' hasAudio: $hasAudio,'
        ' hasVideo: $hasVideo,'
        ' cameraSwitched: $cameraSwitched,'
        ' chat: $chat,'
        ' currentUser: $currentUser,'
        ' _currentVideoChatEntity: $currentVideoChatEntity,'
        ' _videoChatEntities: $videoChatEntities,'
        '}';
  }

  VideoChatStateModel copyWith({
    bool? chatStarted,
    bool? hasAudio,
    bool? hasVideo,
    bool? cameraSwitched,
    ChatModel? chat,
    UserModel? currentUser,
    VideoChatModel? currentVideoChatEntity,
    List<VideoChatModel>? videoChatEntities,
  }) {
    return VideoChatStateModel(
      chatStarted: chatStarted ?? this.chatStarted,
      hasAudio: hasAudio ?? this.hasAudio,
      hasVideo: hasVideo ?? this.hasVideo,
      cameraSwitched: cameraSwitched ?? this.cameraSwitched,
      chat: (chat ?? this.chat)?.copyWith(),
      currentUser: (currentUser ?? this.currentUser)?.copyWith(),
      currentVideoChatEntity: currentVideoChatEntity ?? this.currentVideoChatEntity,
      videoChatEntities: videoChatEntities ?? this.videoChatEntities,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatStarted': chatStarted,
      'hasAudio': hasAudio,
      'hasVideo': hasVideo,
      'cameraSwitched': cameraSwitched,
      'chat': chat,
      'currentUser': currentUser,
      '_currentVideoChatEntity': currentVideoChatEntity,
      '_videoChatEntities': videoChatEntities,
    };
  }

  factory VideoChatStateModel.fromMap(Map<String, dynamic> map) {
    return VideoChatStateModel(
      chatStarted: map['chatStarted'] as bool,
      hasAudio: map['hasAudio'] as bool,
      hasVideo: map['hasVideo'] as bool,
      cameraSwitched: map['cameraSwitched'] as bool,
      chat: map['chat'] as ChatModel,
      currentUser: map['currentUser'] as UserModel,
      currentVideoChatEntity: map['_currentVideoChatEntity'] as VideoChatModel,
      videoChatEntities: map['_videoChatEntities'] as List<VideoChatModel>,
    );
  }

  Future<void> dispose() async {
    for (var each in videoChatEntities) {
      await each.videoRenderer?.dispose();
      each.videoRenderer = null;
    }
  }
}

// void startChat() => _chatStarted = true;
//
// void finishChat() => _chatStarted = false;

// void addVideoChat(VideoChatEntity videoChatEntity) {
//   _videoChatEntities.add(videoChatEntity);
// }

// void updateVideoChat(VideoChatEntity videoChatEntity, int index) {
//   _videoChatEntities[index] = videoChatEntity;
// }

// void checkVideoEntitiesBeforeAdding(VideoChatEntity videoChatEntity) {
//   final videoEntity = _videoChatEntities.getValueAndIndexOrNull((element) =>
//       element.chat?.uuid == videoChatEntity.chat?.uuid &&
//       element.user?.id == videoChatEntity.user?.id);
//   if (videoEntity == null) {
//     addVideoChat(videoChatEntity);
//   } else {
//     updateVideoChat(videoChatEntity, videoEntity.$2);
//   }
// }

// void initCurrentUser(UserModel? user) => _currentUser = user;

// void initChannelSubscription(StreamSubscription<void>? channelSubs) {
//   _channelSubscription = channelSubs;
// }
//
// void initPusherChannelClient(PusherChannelsClient pusherClient) {
//   _pusherChannelsClient = pusherClient;
// }

// void initChannelChat(ChatModel? chat) {
//   _chat = chat?.copyWith();
// }
//
// void changeHasAudio({bool? value}) => _hasAudio = value ?? !_hasAudio;
//
// void changeHasVideo({bool? value}) => _hasVideo = value ?? !_hasVideo;
//
// void switchCamera({bool? value}) => _cameraSwitched = value ?? !_cameraSwitched;
//
