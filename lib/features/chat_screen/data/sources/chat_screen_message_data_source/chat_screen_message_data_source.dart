import 'dart:io';

import 'package:yahay/core/global_data/entities/user.dart';

abstract class ChatScreenMessageDataSource {
  Future<void> sendMessage({required User toUser, String? message});

  Future<void> sendPicture({required User toUser, required File file, String? message});

  Future<void> sendVideo({required User toUser, required File file, String? message});
}
