import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  String _url;

  WebSocket? _socket;

  Function()? onOpen;

  Function(dynamic msg)? onMessage;

  Function(int? code, String? reaso)? onClose;

  WebRTCService(this._url);

  void connect() async {
    try {
      _socket = await _connectForSelfSignedCert(_url);

      onOpen?.call();

      _socket?.listen(
        (data) {
          onMessage?.call(data);
        },
        onDone: () {
          onClose?.call(_socket?.closeCode, _socket?.closeReason);
        },
      );

      //
    } catch (e) {
      debugPrint("connection of webrtc error is: $e");
      onClose?.call(500, e.toString());
    }
  }

  void send(data) {
    if (_socket != null) {
      _socket?.add(data);
      debugPrint("sending data: $data");
    }
  }

  void close() {
    if (_socket != null) _socket?.close();
  }

  // connection settings to the websocket
  Future<WebSocket> _connectForSelfSignedCert(String url) async {
    try {
      Random r = Random();
      String key = base64.encode(
        List.generate(8, (_) => r.nextInt(255)),
      );

      HttpClient client = HttpClient(context: SecurityContext());

      client.badCertificateCallback = (cert, host, port) {
        debugPrint('SimpleWebSocket: Allow self-signed certificate => $host:$port. ');
        return true;
      };

      //

      HttpClientRequest request = await client.getUrl(
        Uri.parse(
          url,
        ),
      );

      //

      request.headers.add('Connection', 'Upgrade');
      request.headers.add('Upgrade', 'websocket');
      request.headers.add('Sec-WebSocket-Version', '13');
      request.headers.add('Sec-WebSocket-Key', key.toLowerCase());

      //

      HttpClientResponse response = await request.close();

      //
      var socket = await response.detachSocket();

      //

      var webSocket = WebSocket.fromUpgradedSocket(
        socket,
        protocol: 'signaling',
        serverSide: false,
      );

      //

      return webSocket;
    } catch (e) {
      throw e;
    }
  }
  
}
