import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/features/add_contact_feature/view/popup_openers/open_search_contacts_popup.dart';

class ChatsAppbar extends StatelessWidget {
  const ChatsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Chats",
        style: GoogleFonts.aBeeZee(),
      ),
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      leading: IconButton(
        onPressed: () => OpenSearchContactsPopup.openSearchContactsPopup(context),
        icon: const Icon(Icons.person_add_alt),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.gear,
            size: 20,
          ),
        ),
      ],
    );
  }
}
