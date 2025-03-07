import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/core/models/chat_message_model/chat_message_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';

class MessageWidget extends StatefulWidget {
  final UserModel? currentUser;
  final ChatMessageModel? message;

  const MessageWidget({super.key, required this.message, required this.currentUser});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.message?.user?.id == widget.currentUser?.id) {
      return _RightSide(message: widget.message);
    } else {
      return _LeftSide(message: widget.message);
    }
  }
}

class _LeftSide extends StatelessWidget {
  final ChatMessageModel? message;

  const _LeftSide({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 4, left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${message?.message}",
                style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              _MessageTime(message: message, showSeen: false),
            ],
          ),
        ),
      ],
    );
  }
}

class _RightSide extends StatelessWidget {
  final ChatMessageModel? message;

  const _RightSide({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4, right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${message?.message}",
                style: GoogleFonts.aBeeZee(fontSize: 13, color: Colors.white),
              ),
              _MessageTime(message: message),
            ],
          ),
        ),
      ],
    );
  }
}

class _MessageTime extends StatelessWidget {
  final bool showSeen;
  final ChatMessageModel? message;

  const _MessageTime({required this.message, this.showSeen = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat.yMMMd().format(DateTime.parse(message?.createdAt ?? Constants.tempDateTime)),
          style: GoogleFonts.aBeeZee(
            fontSize: 9,
            height: 0,
            color: Colors.white70,
            fontWeight: FontWeight.w100,
          ),
        ),
        if (showSeen) const SizedBox(width: 3),
        if (showSeen)
          if (message?.messageSent ?? false)
            SizedBox(
              width: 15,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  const Icon(Icons.check, size: 13, color: Colors.white),
                  if (message?.messageSeenAt != null)
                    const Positioned(
                      left: 5,
                      child: Icon(Icons.check, size: 13, color: Colors.white),
                    ),
                ],
              ),
            )
          else
            const Icon(Icons.access_time_outlined, size: 13, color: Colors.white),
      ],
    );
  }
}
