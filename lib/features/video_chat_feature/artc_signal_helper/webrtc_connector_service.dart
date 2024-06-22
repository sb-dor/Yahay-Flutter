import 'package:flutter/cupertino.dart';
import 'package:yahay/core/utils/dotenv/dotenv.dart';
import 'package:yahay/features/video_chat_feature/artc_signal_helper/webrtc_service.dart';
import 'package:yahay/injections/injections.dart';

class WebrtcConnectorService {
  Future<void> connect() async {
    var url = Uri(
      scheme: "ws",
      host: snoopy<DotEnvHelper>().dotEnv.get("PUSHER_HOST"),
      port: int.tryParse(snoopy<DotEnvHelper>().dotEnv.get("PUSHER_PORT")),
    ).path;

    debugPrint("websocket url path: $url");

    final socket = WebRTCService(url);

    // final turnCredential = await ;

  }
}
