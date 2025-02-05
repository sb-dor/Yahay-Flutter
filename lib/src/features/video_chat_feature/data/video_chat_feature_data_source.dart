import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yahay/src/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';
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
  //
  VideoChatFeatureDataSourceImpl({
    required RestClientBase restClientBase,
  }) : _restClientBase = restClientBase;

  final RestClientBase _restClientBase;

  final _joinChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/videochat/entrance";
  final _startVideoChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/start/videochat";
  final _leaveVideoChatPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/leave/videochat";
  final _steamTheVideoPath = "${AppHttpRoutes.chatsVideoStreamPrefix}/video/stream";

  @override
  Future<bool> startVideoChat(VideoChatModel videoChatEntity) async {
    try {
      final response = await _restClientBase.put(
        _startVideoChatPath,
        data: videoChatEntity.toJson(),
      );

      if (response == null) return false;

      if (!response.containsKey("success")) return false;

      if (bool.tryParse("${response['success']}") == null) return false;

      // start from here tomorrow
      return bool.parse("${response['success']}");
    } on RestClientException {
      rethrow;
    }
  }

  @override
  Future<bool> videoChatEntrance(VideoChatModel videoChatEntity) async {
    try {
      final response = await _restClientBase.put(
        _joinChatPath,
        data: videoChatEntity.toJson(),
      );

      if (response == null) return false;

      if (!response.containsKey("success")) return false;

      if (bool.tryParse("${response['success']}") == null) return false;

      return bool.parse("${response['success']}");
    } on RestClientException {
      rethrow;
    }
  }

  @override
  Future<bool> leaveTheChat(VideoChatModel videoChatEntity) async {
    try {
      final response = await _restClientBase.put(
        _leaveVideoChatPath,
        data: videoChatEntity.toJson(),
      );

      if (response == null) return false;

      if (!response.containsKey("success")) return false;

      if (bool.tryParse("${response['success']}") == null) return false;

      return bool.parse("${response['success']}");
    } on RestClientException {
      rethrow;
    }
  }

  @override
  Future<void> streamTheVideo({
    required VideoChatModel videoChatEntity,
  }) async {
    try {
      final jsonBody = videoChatEntity.toJson();
      log("sending uint8list data: $jsonBody");

      final response = await _restClientBase.put(
        _steamTheVideoPath,
        data: jsonBody,
      );

      debugPrint("coming response from stream video: $response");
    } on RestClientException {
      rethrow;
    }
  }
}
