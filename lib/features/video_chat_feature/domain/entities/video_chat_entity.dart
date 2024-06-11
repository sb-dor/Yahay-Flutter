import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';

class VideoChatEntity {
  Uint8List? imageData;
  final String videoChatId; // for double security
  final Chat? chat;
  final User? user;

  VideoChatEntity({
    required this.imageData,
    required this.chat,
    required this.user,
  }) : videoChatId = const Uuid().v4();
}
