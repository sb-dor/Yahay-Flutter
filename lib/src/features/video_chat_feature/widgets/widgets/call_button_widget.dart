import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/state_model/video_chat_state_model.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_events.dart';

class CallButtonWidget extends StatefulWidget {
  final VideoChatFeatureBloc videoChatBloc;

  const CallButtonWidget({
    super.key,
    required this.videoChatBloc,
  });

  @override
  State<CallButtonWidget> createState() => _CallButtonWidgetState();
}

class _CallButtonWidgetState extends State<CallButtonWidget> {
  late final VideoChatFeatureBloc _videoChatFeatureBloc;
  late final VideoChatStateModel _videoChatStateModel;

  @override
  void initState() {
    super.initState();
    _videoChatFeatureBloc = widget.videoChatBloc;
    _videoChatStateModel = _videoChatFeatureBloc.states.value.videoChatStateModel;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Material(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () async {
                  Navigator.pop(context);
                },
                child: const SizedBox(
                  width: 90,
                  height: 90,
                  child: Center(
                    child: Icon(
                      CupertinoIcons.phone_down,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Decline",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5
              ),
            ),
          ],
        ),
        Column(
          children: [
            Material(
              color: _videoChatStateModel.chat?.videoChatRoom != null ? Colors.blue : Colors.green,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  if (_videoChatStateModel.chat?.videoChatRoom != null) {
                    debugPrint("working22  here");
                    _videoChatFeatureBloc.events.add(const VideoChatEntranceEvent());
                  } else {
                    debugPrint("working11  here");
                    _videoChatFeatureBloc.events.add(const StartVideoChatEvent());
                  }
                },
                child: const SizedBox(
                  width: 90,
                  height: 90,
                  child: Center(
                    child: Icon(
                      Icons.call,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _videoChatStateModel.chat?.videoChatRoom != null ? "Accept" : "Call",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5
              ),
            ),
          ],
        ),
      ],
    );
  }
}
