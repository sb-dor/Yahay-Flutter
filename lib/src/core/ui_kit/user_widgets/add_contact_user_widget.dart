import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/ui_kit/image_loader/image_loaded.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';

class AddContactUserWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback addUser;

  const AddContactUserWidget({super.key, required this.user, required this.addUser});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => [],
      child: ColoredBox(
        color: Colors.transparent,
        child: IntrinsicHeight(
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: ImageLoaderWidget(
                  url: user.imageUrl ?? '',
                  errorWidget: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    child: Center(
                      child: Text(
                        user.getFirstAndLastLetterOfName(),
                        style: GoogleFonts.aBeeZee(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user.name ?? user.email ?? '-', style: GoogleFonts.aBeeZee(fontSize: 15)),
                    Text(
                      "Last seen 3000 y.a",
                      style: GoogleFonts.aBeeZee(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (user.contact != null)
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    AutoRouter.of(context).push(ChatRoute(chat: null, user: user));
                  },
                  icon: const Icon(CupertinoIcons.chat_bubble_2_fill),
                )
              else if ((user.loadingForAddingToContacts ?? false))
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 15,
                  height: 15,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              else
                IconButton(onPressed: addUser, icon: const Icon(Icons.person_add_alt)),
            ],
          ),
        ),
      ),
    );
  }
}
