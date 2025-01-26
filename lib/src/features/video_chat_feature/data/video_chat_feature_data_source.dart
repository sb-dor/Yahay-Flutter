import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/src/features/video_chat_feature/models/video_chat_model.dart';

abstract interface class VideoChatFeatureDataSource {
  // for starting the video chat
  Future<bool> startVideoChat(VideoChatModel videoChatEntity);

  // for entrance in video chat if someone has already called
  Future<bool> videoChatEntrance(VideoChatModel videoChatEntity);

  // for leaving the video chat
  Future<bool> leaveTheChat(VideoChatModel videoChatEntity);

  // streaming the video data feature
  Future<void> streamTheVideo({
    required VideoChatModel videoChatEntity,
  });
}

class VideoChatFeatureDataSourceImpl implements VideoChatFeatureDataSource {
  final _dioHelper = DioSettings.instance;
  final _joinChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/videochat/entrance";
  final _startVideoChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/start/videochat";
  final _leaveVideoChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/leave/videochat";
  final _steamTheVideoPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/video/stream";

  @override
  Future<bool> startVideoChat(VideoChatModel videoChatEntity) async {
    try {
      final response = await _dioHelper.dio.put(
        _startVideoChatPath,
        data: videoChatEntity.toJson(),
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
  Future<bool> videoChatEntrance(VideoChatModel videoChatEntity) async {
    try {
      final response = await _dioHelper.dio.put(
        _joinChatPath,
        data: videoChatEntity.toJson(),
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
  Future<bool> leaveTheChat(VideoChatModel videoChatEntity) async {
    try {
      final response = await _dioHelper.dio.put(
        _leaveVideoChatPath,
        data: videoChatEntity.toJson(),
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
    required VideoChatModel videoChatEntity,
  }) async {
    try {
      final jsonBody = videoChatEntity.toJson();
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
