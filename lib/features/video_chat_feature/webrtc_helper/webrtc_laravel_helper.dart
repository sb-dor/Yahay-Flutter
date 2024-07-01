import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_usages/constants/constants.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/features/video_chat_feature/data/models/candidate_model/candidate_model.dart';
import 'package:yahay/features/video_chat_feature/domain/entities/candidate.dart';
import 'package:yahay/injections/injections.dart';

typedef LaravelStreamStateCallback = void Function(MediaStream stream);

typedef SetStateCallbackSignal = void Function();

class WebrtcLaravelHelper {
  final String _url = "http://192.168.100.3:8000/api";
  final _dioHelper = snoopy<DioSettings>();

  // configuration for iceServers
  // they can be used for free
  // forex "stun" servers which are from google and there are for free usage
  // and "stun" servers are for changing your local IP into real IP (192.168..) into (64.25)

  // STUN - servers are necessary for connecting clients or devices in order each of them know
  // their external IP-address. It's necessary for properly making "communication" between computer
  // and other resources in internet
  //
  // all other "stun" servers you can find here:
  // https://gist.github.com/mondain/b0ec1cf5f60ae726202e
  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302',
        ]
      }
    ]
  };

  // it's very necessary for webrtc part
  RTCPeerConnection? peerConnection;

  // media stream are for getting video from camera and audio
  MediaStream? localStream;
  MediaStream? remoteStream;

  // our future room id to participation
  String? roomId;
  String? currentRoomText;

  //
  //
  LaravelStreamStateCallback? onAddRemoteStream;

  SetStateCallbackSignal? setSetStateCallback;

  StreamSubscription<void>? calleeStreamSubs; // same channel stream but accepts different data

  StreamSubscription<void>? callerStreamSubs; // same channel stream but accepts different data

  Future<String> createRoom(Chat? chat) async {
    try {
      //
      peerConnection = await createPeerConnection(configuration);

      registerPeerConnectionListeners();

      localStream?.getTracks().forEach((track) {
        peerConnection?.addTrack(track, localStream!);
      });

      // Create an offer
      RTCSessionDescription offer = await peerConnection!.createOffer();

      await peerConnection!.setLocalDescription(offer);

      // print('Created offer ${await peerConnection?.getLocalDescription()}');

      // Send offer to backend
      var response = await _dioHelper.dio.post(
        '$_url/create-room',
        data: {
          'offer': offer.toMap(),
          "chat_id" : chat?.id,
        },
      );

      var data = response.data is String ? jsonDecode(response.data) : response.data;

      var roomId = data['roomId'];

      peerConnection?.onTrack = (RTCTrackEvent event) {
        event.streams[0].getTracks().forEach((track) {
          remoteStream?.addTrack(track);
        });
      };

      // Code for collecting ICE candidates
      peerConnection?.onIceCandidate = (RTCIceCandidate? candidate) {
        if (candidate == null) {
          return;
        }
        addIceCandidate(candidate, roomId.toString(), 'caller');
      };

      ///
      ///
      ///
      try {
        final pusherService = await snoopy<PusherClientService>().subscriptionCreator();

        final channel = pusherService.publicChannel(Constants.webRtcChannelName);

        calleeStreamSubs = pusherService.onConnectionEstablished.listen((e) {
          channel.subscribeIfNotUnsubscribed();
        });

        await pusherService.connect();

        channel.bind(Constants.webRtcChannelEventName).listen((e) async {
          // code here tomorrow
          Map<String, dynamic> data = e.data is String ? jsonDecode(e.data.toString()) : e.data;

          if (data.containsKey("answer")) {
            String sdp = data['answer']['sdp'] + "\n";
            String type = data['answer']['type'];

            var answer = RTCSessionDescription(
              sdp,
              type,
            );
            log("will here work hellu: $sdp");
            // if (peerConnection?.signalingState ==
            //     RTCSignalingState.RTCSignalingStateHaveLocalOffer) {
            if (await peerConnection?.getRemoteDescription() == null) {
              await peerConnection?.setRemoteDescription(answer);
              final responseCandidates = await _dioHelper.dio.get(
                "$_url/get-ice-candidates/$roomId/callee",
              );

              Map<String, dynamic> mapOfData = responseCandidates.data is String
                  ? jsonDecode(responseCandidates.data)
                  : responseCandidates.data;

              //
              List<dynamic> listOfCandidates = mapOfData['candidates'];

              List<Candidate> candidates =
                  listOfCandidates.map((e) => CandidateModel.fromJson(e)).toList();

              for (final each in candidates) {
                await peerConnection?.addCandidate(RTCIceCandidate(
                  each.candidate.candidate,
                  each.candidate.sdpMid,
                  each.candidate.sdpMLineIndex,
                ));
              }
              setSetStateCallback?.call();
              // await peerConnection?.setLocalDescription(offer);
              // } else {
              //   await peerConnection?.setRemoteDescription(answer);
              // }
            }
          }

          // if (data.containsKey("candidate") &&
          //     data.containsKey("role") &&
          //     data['role'] == 'callee') {
          //   debugPrint("coming candidate data");
          //   peerConnection?.addCandidate(RTCIceCandidate(
          //     data['candidate']['candidate'],
          //     data['candidate']['sdpMid'],
          //     data['candidate']['sdpMLineIndex'],
          //   ));
          //   // setStateFunction;
          // }
        });
      } catch (e) {
        debugPrint("creating pusher for creating room error is: $e");
      }

      ///
      ///
      ///
      ///

      // this.roomId = roomId;
      return roomId.toString();
    } catch (e) {
      debugPrint("creating room error is: $e");
      return '';
    }
  }

  Future<void> joinRoom(String roomId, RTCVideoRenderer remoteVideo) async {
    // try {

    // for getting room configuration
    var responseForRemoteConfig = await _dioHelper.dio.post(
      '$_url/join-room',
      data: {
        'roomId': roomId,
      },
    );

    peerConnection = await createPeerConnection(configuration);

    registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    peerConnection!.onIceCandidate = (RTCIceCandidate? candidate) {
      if (candidate == null) {
        return;
      }
      addIceCandidate(candidate, roomId, 'callee');
    };

    peerConnection?.onTrack = (RTCTrackEvent event) {
      event.streams[0].getTracks().forEach((track) {
        remoteStream?.addTrack(track);
      });
    };

    var data = responseForRemoteConfig.data is String
        ? jsonDecode(responseForRemoteConfig.data)
        : responseForRemoteConfig.data;

    var offer = data['offer'];

    String sdp = offer['sdp'] + "\n";
    String type = offer['type'];

    if (sdp.isEmpty || type.isEmpty) {
      throw Exception('SDP or Type is empty');
    }

    // sdp = sdp.replaceAll("\r\na=extmap-allow-mixed", "");

    RTCSessionDescription remoteDescription = RTCSessionDescription(sdp, type);

    try {
      await peerConnection?.setRemoteDescription(remoteDescription);
      debugPrint("remote description successfully added");
    } catch (e) {
      debugPrint("peer connection set remote desc failed: $e");
    }

    try {
      var answer = await peerConnection!.createAnswer();

      await peerConnection!.setLocalDescription(answer);

      var response = await _dioHelper.dio.post(
        '$_url/join-room',
        data: {
          'roomId': roomId,
          'answer': answer.toMap(),
        },
      );
    } catch (e) {
      debugPrint("creating answer error is: $e");
    }

    // Create an answer
    ///
    ///
    ///
    ///
    ///
    ///

    // get candidates data before listening them
    final responseCandidates = await _dioHelper.dio.get(
      "$_url/get-ice-candidates/$roomId/caller",
    );

    Map<String, dynamic> mapOfData = responseCandidates.data is String
        ? jsonDecode(responseCandidates.data)
        : responseCandidates.data;
    //
    List<dynamic> listOfCandidates = mapOfData['candidates'];

    List<Candidate> candidates = listOfCandidates.map((e) => CandidateModel.fromJson(e)).toList();

    for (final each in candidates) {
      await peerConnection?.addCandidate(RTCIceCandidate(
        each.candidate.candidate,
        each.candidate.sdpMid,
        each.candidate.sdpMLineIndex,
      ));
    }

    //
    final pusherService = await snoopy<PusherClientService>().subscriptionCreator();

    final channel = pusherService.publicChannel(Constants.webRtcChannelName);

    callerStreamSubs = pusherService.onConnectionEstablished.listen((e) {
      channel.subscribeIfNotUnsubscribed();
    });

    channel.bind(Constants.webRtcChannelEventName).listen((e) async {
      // code here tomorrow
      Map<String, dynamic> data = e.data is String ? jsonDecode(e.toString()) : e.data;

      if (data.containsKey("candidate") && data.containsKey("role") && data['role'] == 'caller') {
        peerConnection?.addCandidate(RTCIceCandidate(
          data['candidate']['candidate'],
          data['candidate']['sdpMid'],
          data['candidate']['sdpMLineIndex'],
        ));
      }
    });

    ///
    ///
    ///
    ///

    // } catch (e) {
    //   debugPrint("is any error in join room: $e");
    // }
  }

  Future<void> openUserMedia(
    RTCVideoRenderer localVideo,
    // RTCVideoRenderer remoteVideo, // was removed temporary
  ) async {
    var stream = await navigator.mediaDevices.getUserMedia({
      'video': true,
      'audio': true, // set false in the future
    });

    localVideo.srcObject = stream;
    localStream = stream;

    // remoteVideo.srcObject = await createLocalMediaStream('key'); // was removed temporary
  }

  // close all
  Future<void> hangUp(
    RTCVideoRenderer localVideo,
  ) async {
    localVideo.srcObject!.getTracks().forEach(((track) async => await track.stop()));

    if (remoteStream != null) {
      remoteStream!.getTracks().forEach((track) async => await track.stop());
    }
    if (peerConnection != null) peerConnection!.close();

    if (roomId != null) {
      // write code for turning off the conversation

      // var db = FirebaseFirestore.instance;
      // var roomRef = db.collection('rooms').doc(roomId);
      // var calleeCandidates = await roomRef.collection('calleeCandidates').get();
      // calleeCandidates.docs.forEach((document) => document.reference.delete());
      //
      // var callerCandidates = await roomRef.collection('callerCandidates').get();
      // callerCandidates.docs.forEach((document) => document.reference.delete());
      //
      // await roomRef.delete();
    }

    calleeStreamSubs?.cancel();
    callerStreamSubs?.cancel();
    localStream!.dispose();
    remoteStream?.dispose();
    localVideo.dispose();
  }

  void addIceCandidate(
    RTCIceCandidate candidate,
    String roomId,
    String role,
  ) async {
    final response = await _dioHelper.dio.post(
      '$_url/add-ice-candidate',
      data: {
        'roomId': roomId,
        'candidate': candidate.toMap(),
        'role': role,
      },
    );
  }

  Future<void> getIceCandidates(String roomId, String role) async {
    var response = await _dioHelper.dio.get(
      '$_url/api/get-ice-candidates/$roomId/$role',
    );

    var data = response.data is String ? jsonDecode(response.data) : response.data;
    var candidates = data['candidates'];

    for (var candidate in candidates) {
      peerConnection!.addCandidate(
        RTCIceCandidate(
          candidate['candidate'],
          candidate['sdpMid'],
          candidate['sdpMLineIndex'],
        ),
      );
    }
  }

  void registerPeerConnectionListeners() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      debugPrint('ICE gathering state changed: $state');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      debugPrint('Connection state change: $state');
    };

    peerConnection?.onSignalingState = (RTCSignalingState state) {
      debugPrint('Signaling state change: $state');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      debugPrint('ICE connection state change: $state');
    };

    peerConnection?.onAddStream = (MediaStream stream) {
      debugPrint("Add remote stream");
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
    };
  }
}
