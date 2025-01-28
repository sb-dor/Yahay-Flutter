import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:yahay/src/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/features/chat_screen/data/sources/chat_screen_message_data_source/chat_screen_message_data_source.dart';

class ChatScreenMessageDataSourceImpl extends ChatScreenMessageDataSource {
  //
  ChatScreenMessageDataSourceImpl({
    required final DioSettings dioSettings,
  }) : _dioSettings = dioSettings;

  final DioSettings _dioSettings;

  static const String _messageSendUrl = "${AppHttpRoutes.chatsPrefix}/message/handler";

  @override
  Future<void> sendMessage({required ChatMessageModel chatMessage}) async {
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
    required ChatModel? chat,
    required UserModel? toUser,
    required File file,
    String? message,
  }) {
    // TODO: implement sendPicture
    throw UnimplementedError();
  }

  @override
  Future<void> sendVideo({
    required ChatModel? chat,
    required UserModel? toUser,
    required File file,
    String? message,
  }) {
    // TODO: implement sendVideo
    throw UnimplementedError();
  }
}
