import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:yahay/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/features/video_chat_feature/data/models/video_chat_model.dart';
import 'package:yahay/features/video_chat_feature/data/sources/video_chat_feature_data_source/video_chat_feature_data_source.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/video_chat_entity.dart';
import 'package:yahay/injections/injections.dart';

class VideoChatFeatureDataSourceImpl implements VideoChatFeatureDataSource {
  final _dioHelper = snoopy<DioSettings>();

  final joinChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/videochat/entrance";
  final startVideoChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/start/videochat";

  @override
  Future<bool> startVideoChat(VideoChatEntity videoChatEntity) async {
    try {
      final response = await _dioHelper.dio.put(
        startVideoChatPath,
        data: VideoChatModel.fromEntity(videoChatEntity)?.toJson(),
      );

      debugPrint("start video chat response is: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return false;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey("success")) return false;

      if (bool.tryParse("${json['success']}") == null) return false;

      // start from here tomorrow
      return bool.parse("${json['success']}");
    } catch (e) {
      debugPrint("start chat error is: $e");
      return false;
    }
  }

  @override
  Future<bool> videoChatEntrance(VideoChatEntity videoChatEntity) async {
    try {
      final response = await _dioHelper.dio.put(
        joinChatPath,
        data: VideoChatModel.fromEntity(videoChatEntity)?.toJson(),
      );

      debugPrint("joinToChat response is: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return false;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey("success")) return false;

      if (bool.tryParse("${json['success']}") == null) return false;

      return bool.parse("${json['success']}");
    } catch (e) {
      debugPrint("joinToChat error is: $e");
      return false;
    }
  }

  @override
  Future<bool> leaveTheChat(VideoChatEntity videoChatEntity) {
    // TODO: implement leaveTheChat
    throw UnimplementedError();
  }

  @override
  Future<void> streamTheVideo(Uint8List int8) {
    // TODO: implement streamTheVideo
    throw UnimplementedError();
  }
}
