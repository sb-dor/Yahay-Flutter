import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:yahay/src/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/src/features/video_chat_feature/data/models/video_chat_model.dart';
import 'package:yahay/src/features/video_chat_feature/data/sources/video_chat_feature_data_source/video_chat_feature_data_source.dart';
import 'package:yahay/src/features/video_chat_feature/domain/entities/video_chat_entity.dart';

class VideoChatFeatureDataSourceImpl implements VideoChatFeatureDataSource {
  final _dioHelper = DioSettings.instance;
  final _joinChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/videochat/entrance";
  final _startVideoChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/start/videochat";
  final _leaveVideoChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/leave/videochat";
  final _steamTheVideoPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/video/stream";

  @override
  Future<bool> startVideoChat(VideoChatEntity videoChatEntity) async {
    try {
      final response = await _dioHelper.dio.put(
        _startVideoChatPath,
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
        _joinChatPath,
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
  Future<bool> leaveTheChat(VideoChatEntity videoChatEntity) async {
    try {
      final response = await _dioHelper.dio.put(
        _leaveVideoChatPath,
        data: VideoChatModel.fromEntity(videoChatEntity)?.toJson(),
      );

      debugPrint("leaveTheChat response is: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return false;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey("success")) return false;

      if (bool.tryParse("${json['success']}") == null) return false;

      return bool.parse("${json['success']}");
    } catch (e) {
      debugPrint("leave the chat error is: $e");
      return false;
    }
  }

  @override
  Future<void> streamTheVideo({
    required VideoChatEntity videoChatEntity,
  }) async {
    try {
      final jsonBody = VideoChatModel.fromEntity(videoChatEntity)?.toJson();
      log("sending uint8list data: $jsonBody");

      final response = await _dioHelper.dio.put(
        _steamTheVideoPath,
        data: jsonBody,
      );

      debugPrint("coming response from stream video: ${response.data}");
    } on DioException {
      // error
    }
  }
}
