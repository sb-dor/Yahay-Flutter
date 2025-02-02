import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:yahay/src/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/utils/dio/src/rest_client_base.dart';
import 'package:yahay/src/core/utils/dio/src/status_codes/http_server_responses.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/utils/extensions/extentions.dart';
import 'package:yahay/src/features/chat_screen/data/sources/chat_screen_chat_data_source/chat_screen_chat_data_souce.dart';

class ChatScreenChatDataSourceImpl implements ChatScreenChatDataSource {
  //
  ChatScreenChatDataSourceImpl({
    required final RestClientBase restClientBase,
  }) : _restClientBase = restClientBase;

  final RestClientBase _restClientBase;

  final String _getChatUrl = "${AppHttpRoutes.chatsPrefix}/get/chat/on/entrance";
  final String _deleteTempCreatedChatsUrl =
      "${AppHttpRoutes.chatsPrefix}/delete/temp/created/chats";

  @override
  Future<ChatModel?> chat({ChatModel? chat, UserModel? withUser}) async {
    try {
      final body = {
        "chat_uuid": chat?.uuid,
        'with_user_id': withUser?.id,
      };

      final response = await _restClientBase.post(_getChatUrl, data: body);

      if (response == null) return null;

      if (!response.containsKey("chat")) return null;

      final gettingChat = ChatModel.fromJson(
        response.getNested(
          ['chat'],
        ),
      );

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
  Future<void> removeAllTempCreatedChats({required ChatModel? chat}) async {
    try {
      final body = {"chat_id": chat?.id, "chat_uuid": chat?.uuid};

      final response = await _restClientBase.delete(_deleteTempCreatedChatsUrl, data: body);

      debugPrint("coming remove temp created chats: $response");
    } catch (e) {
      debugPrint("removeAllTempCreatedChats error is: $e");
    }
  }
}
