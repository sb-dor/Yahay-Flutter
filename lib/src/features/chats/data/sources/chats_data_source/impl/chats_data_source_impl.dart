import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:yahay/src/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/utils/dio/src/rest_client_base.dart';
import 'package:yahay/src/core/utils/dio/src/status_codes/http_status_codes.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/features/chats/data/sources/chats_data_source/chats_data_source.dart';

class ChatsDataSourceImpl implements ChatsDataSource {
  //
  ChatsDataSourceImpl({
    required final RestClientBase restClientBase,
  }) : _restClientBase = restClientBase;

  final RestClientBase _restClientBase;

  final String _getUserChatsUrl = "${AppHttpRoutes.chatsPrefix}/get/chats";

  @override
  Future<List<ChatModel>> chats() async {
    try {
      final response = await _dioHelper.dio.get(_getUserChatsUrl);

      debugPrint("chats response: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return <ChatModel>[];

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey(HttpStatusCodes.serverSuccessResponse)) return <ChatModel>[];

      final List<dynamic> listD = json['chats'];

      final result = listD.map((e) => ChatModel.fromJson(e)).toList();

      return result;
    } catch (e) {
      debugPrint("chats error is: $e");
      return <ChatModel>[];
    }
  }
}
