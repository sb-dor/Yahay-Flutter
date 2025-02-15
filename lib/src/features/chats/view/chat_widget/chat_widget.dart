import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';
import 'package:yahay/src/core/ui_kit/image_loader/image_loaded.dart';
import 'package:yahay/src/core/ui_kit/splash_button_clicker.dart';

class ChatWidget extends StatelessWidget {
  final ChatModel? chat;

  const ChatWidget({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return SplashButtonClicker(
      splashColor: Colors.green.shade100,
      onTap: () {
        AutoRouter.of(context).push(
          ChatRoute(
            chat: chat,
            user: null,
          ),
        );
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
            ),
            if (chat?.videoChatStreaming ?? false)
              IconButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    VideoChatFeatureRoute(
                      chat: chat,
                    ),
                  );
                },
                icon: const Icon(
                  CupertinoIcons.videocam,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ChatMainImage extends StatelessWidget {
  final ChatModel? chat;

  const _ChatMainImage({
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    if ((chat?.participants?.length ?? 0) > 1) {
      if (chat?.imageUrl != null) {
        return _ChatImageBuilder(path: chat?.imageUrl);
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CircleAvatar(
            radius: 30,
            child: Container(
              color: Colors.green,
              child: Text(chat?.getWrappedName() ?? '-'),
            ),
          ),
        );
      }
    } else if ((chat?.participants?.length ?? 0) == 1) {
      return _ChatImageBuilder(path: chat?.participants?.first.user?.imageUrl);
    } else {
      return Text(chat?.getWrappedName() ?? '-');
    }
  }
}

class _ChatImageBuilder extends StatelessWidget {
  final String? path;

  const _ChatImageBuilder({required this.path});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CircleAvatar(
        radius: 30,
        child: ImageLoaderWidget(
          url: path ?? '',
          errorImageUrl: Constants.defaultUserImage,
        ),
      ),
    );
  }
}

class _ChatName extends StatelessWidget {
  final ChatModel? chat;

  const _ChatName({
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
      final user = chat?.participants?.first.user;
      return Text(
        user?.name ?? user?.email ?? '-',
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
