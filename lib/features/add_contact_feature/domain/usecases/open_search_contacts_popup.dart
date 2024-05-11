import 'package:flutter/material.dart';
import 'package:yahay/features/add_contact_feature/view/pages/add_contacts_page.dart';

abstract class OpenSearchContactsPopup {
  static Future<void> openSearchContactsPopup(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (context) => const AddContactsPage(),
    );
  }
}
