import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:yahay/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/core/global_data/models/chats_model/chat_model.dart';
import 'package:yahay/features/chats/data/sources/chats_data_source/chats_data_source.dart';
import 'package:yahay/injections/injections.dart';

class ChatsDataSourceImpl implements ChatsDataSource {
  final _dioHelper = snoopy<DioSettings>();

  static const String _getUserChatsUrl = "${AppHttpRoutes.chatsPrefix}/get/chats";

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
