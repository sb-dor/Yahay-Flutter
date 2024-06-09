import 'package:flutter/material.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_events.dart';

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
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          widget.videoChatBloc.events.add(StartVideoChatEvent(widget.videoChatBloc.events));
        },
        child: const SizedBox(
          width: 80,
          height: 80,
          child: Center(
            child: Icon(Icons.call),
          ),
        ),
      ),
    );
  }
}
