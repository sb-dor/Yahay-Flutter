import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:yahay/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_chat_data_source/chat_screen_chat_data_souce.dart';
import 'package:yahay/injections/injections.dart';

class ChatScreenChatDataSourceImpl implements ChatScreenChatDataSource {
  final _dioSettings = snoopy<DioSettings>();

  static const String _getChatUrl = "${AppHttpRoutes.chatsPrefix}/get/chat/on/entrance";
  static const String _deleteTempCreatedChatsUrl =
      "${AppHttpRoutes.chatsPrefix}/delete/temp/created/chats";

  @override
  Future<ChatModel?> chat({Chat? chat, User? withUser}) async {
    try {
      final body = {
        "chat_uuid": chat?.uuid,
        'with_user_id': withUser?.id,
      };

      late Response response;

      if (kIsWeb) {
        response = await _dioSettings.dio.post(_getChatUrl, data: body);
      } else {
        response = await _dioSettings.dio.get(_getChatUrl, data: body);
      }

      debugPrint("chat response is: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return null;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey("chat")) return null;

      final gettingChat = ChatModel.fromJson(json['chat']);

      return gettingChat.copyWith(
          messages: gettingChat.messages?.map((e) {
        return e.copyWith(messageSent: true);
      }).toList());
    } catch (e) {
      debugPrint("ChatScreenChatDataSourceImpl chat error is: $e");
      return null;
    }
  }

  @override
  Future<void> removeAllTempCreatedChats({required Chat? chat}) async {
    try {
      final body = {"chat_id": chat?.id, "chat_uuid": chat?.uuid};

      final response = await _dioSettings.dio.delete(_deleteTempCreatedChatsUrl, data: body);

      debugPrint("coming remove temp created chats: ${response.data}");
    } catch (e) {
      debugPrint("removeAllTempCreatedChats error is: $e");
    }
  }
}
