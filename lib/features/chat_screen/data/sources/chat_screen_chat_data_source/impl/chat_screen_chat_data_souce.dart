import 'package:flutter/cupertino.dart';
import 'package:yahay/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/features/chat_screen/data/sources/chat_screen_chat_data_source/chat_screen_chat_data_souce.dart';
import 'package:yahay/injections/injections.dart';

class ChatScreenChatDataSourceImpl implements ChatScreenChatDataSource {
  final _dioSettings = snoopy<DioSettings>();

  static const String _getChatUrl = "${AppHttpRoutes.chatsPrefix}/get/chat/on/entrance";

  @override
  Future<ChatModel?> chat({Chat? chat, User? withUser}) async {
    try {
      final body = {
        "chat_id": chat?.id,
        'with_user_id': withUser?.id,
      };

      final response = await _dioSettings.dio.get(_getChatUrl, data: body);
    } catch (e) {
      debugPrint("ChatScreenChatDataSourceImpl chat error is: $e");
      return null;
    }
  }
}
