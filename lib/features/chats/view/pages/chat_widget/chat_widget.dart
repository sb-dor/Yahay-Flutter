import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_usages/widgets/image_loader/image_loaded.dart';
import 'package:yahay/core/global_usages/widgets/splash_button_clicker.dart';

class ChatWidget extends StatelessWidget {
  final Chat? chat;

  const ChatWidget({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return SplashButtonClicker(
      splashColor: Colors.green.shade100,
      onTap: () {
        AutoRouter.of(context).push(ChatRoute(chat: chat, user: null));
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            _ChatMainImage(chat: chat),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ChatName(chat: chat),
                  Text(
                    chat?.lastMessage?.message ?? '-',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ChatMainImage extends StatelessWidget {
  final Chat? chat;

  const _ChatMainImage({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    if ((chat?.participants?.length ?? 0) > 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          radius: 30,
          child: Container(
            color: Colors.green,
            child: const Text(""),
          ),
        ),
      );
    } else if ((chat?.participants?.length ?? 0) == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          radius: 30,
          child: ImageLoaderWidget(url: chat?.participants?.first.user?.imageUrl ?? ''),
        ),
      );
    } else {
      return const Text("");
    }
  }
}

class _ChatName extends StatelessWidget {
  final Chat? chat;

  const _ChatName({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    if ((chat?.participants?.length ?? 0) > 1) {
      return Text(
        chat?.name ?? '-',
        style: GoogleFonts.aBeeZee(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else if ((chat?.participants?.length ?? 0) == 1) {
      return Text(
        chat?.participants?.first.user?.name ?? '-',
        style: GoogleFonts.aBeeZee(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    } else {
      return const Text("");
    }
  }
}
