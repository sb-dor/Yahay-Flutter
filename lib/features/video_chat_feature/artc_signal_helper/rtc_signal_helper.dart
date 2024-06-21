import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/injections/injections.dart';

class Signaling {
  final _dioSettings = snoopy<DioSettings>();
  final String serverUrl;
  late final RTCPeerConnection _peerConnection;
  final RTCVideoRenderer _localRenderer;
  final RTCVideoRenderer _remoteRenderer;

  Signaling(this.serverUrl, this._localRenderer, this._remoteRenderer);

  // Future<void> callUser(String userId) async {
  //   final response = await _dioSettings.dio.post(
  //     '/call-user',
  //     data: {'user_id': userId},
  //   );
  //   // Handle response
  // }
  //
  // Future<void> answerCall(String callId) async {
  //   final response = await _dioSettings.dio.post(
  //     "/answer-call",
  //     data: {'call_id': callId},
  //   );
  //   // Handle response
  // }

  Future<void> createOffer() async {
    // Create and set up peer connection, local and remote descriptions
    // _peerConnection = await createPeerConnection({
    //   //
    // });
    // _peerConnection.onIceCandidate = (candidate) {
    //   // Send candidate to signaling server
    // };
    // _peerConnection.onAddStream = (stream) {
    //   _remoteRenderer.srcObject = stream;
    // };

    MediaStream stream = await navigator.mediaDevices.getUserMedia({'video': true});
    _localRenderer.srcObject = stream;
    _peerConnection.addStream(stream);

    RTCSessionDescription offer = await _peerConnection.createOffer();
    _peerConnection.setLocalDescription(offer);

    // Send offer to signaling server
  }

  Future<void> createAnswer() async {
    // Create and set up peer connection, local and remote descriptions
    _peerConnection = await createPeerConnection({
      //
    });
    _peerConnection.onIceCandidate = (candidate) {
      // Send candidate to signaling server
    };
    _peerConnection.onAddStream = (stream) {
      _remoteRenderer.srcObject = stream;
    };

    MediaStream stream = await navigator.mediaDevices.getUserMedia({'video': true});
    _localRenderer.srcObject = stream;
    _peerConnection.addStream(stream);

    RTCSessionDescription answer = await _peerConnection.createAnswer();
    _peerConnection.setLocalDescription(answer);

    // Send answer to signaling server
  }
}
