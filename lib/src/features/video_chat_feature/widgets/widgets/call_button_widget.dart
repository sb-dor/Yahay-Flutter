import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/features/video_chat_feature/bloc/video_chat_feature_bloc.dart';

class CallButtonWidget extends StatefulWidget {
  const CallButtonWidget({
    super.key,
  });

  @override
  State<CallButtonWidget> createState() => _CallButtonWidgetState();
}

class _CallButtonWidgetState extends State<CallButtonWidget> {
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
                  context.read<VideoChatBloc>().add(
                    VideoChatFeatureEvents.finishVideoChatEvent(
                      popScreen: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1.5),
            ),
          ],
        ),
        BlocBuilder<VideoChatBloc, VideoChatFeatureStates>(
          builder: (context, state) {
            return Column(
              children: [
                Material(
                  color: state.videoChatStateModel.chat?.videoChatRoom != null
                      ? Colors.blue
                      : Colors.green,
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      if (state.videoChatStateModel.chat?.videoChatRoom != null) {
                        debugPrint("working22  here");
                        context
                            .read<VideoChatBloc>()
                            .add(const VideoChatFeatureEvents.videoChatEntranceEvent());
                      } else {
                        debugPrint("working11  here");
                        context
                            .read<VideoChatBloc>()
                            .add(const VideoChatFeatureEvents.startVideoChatEvent());
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
                  state.videoChatStateModel.chat?.videoChatRoom != null ? "Accept" : "Call",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1.5),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
