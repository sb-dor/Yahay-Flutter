import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:yahay/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat_message.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_message_data_source/chat_screen_message_data_source.dart';

class ChatScreenMessageDataSourceImpl extends ChatScreenMessageDataSource {
  final _dioSettings = DioSettings.instance;

  static const String _messageSendUrl = "${AppHttpRoutes.chatsPrefix}/message/handler";

  @override
  Future<void> sendMessage({required ChatMessage chatMessage}) async {
    try {
      final toJson = <String, Object?>{
        "chat_id": chatMessage.chat?.id,
        "user_id": chatMessage.user?.id,
        "related_to_user_id": chatMessage.relatedToUser?.id,
        "chat_message_uuid": chatMessage.chatMessageUUID.toString(),
        "message": chatMessage.message,
        "created_at": chatMessage.createdAt,
      };

      if (chatMessage.file != null) {
        // why array ? -> because in future I will send the list of files
        toJson['files[]'] = [
          await MultipartFile.fromFile(
            chatMessage.file?.path ?? '',
            filename: "file_name_${chatMessage.file?.path ?? ''}",
          )
        ];
      }

      debugPrint("sending data is: $toJson");

      final formData = FormData.fromMap(toJson);

      final response = await _dioSettings.dio.post(_messageSendUrl, data: formData);

      debugPrint("reponseddata: ${response.data}");
    } catch (e) {
      debugPrint("ChatScreenMessageDataSourceImpl sendMessage error is: $e");
    }
  }

  @override
  Future<void> sendPicture({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  }) {
    // TODO: implement sendPicture
    throw UnimplementedError();
  }

  @override
  Future<void> sendVideo({
    required Chat? chat,
    required User? toUser,
    required File file,
    String? message,
  }) {
    // TODO: implement sendVideo
    throw UnimplementedError();
  }
}
