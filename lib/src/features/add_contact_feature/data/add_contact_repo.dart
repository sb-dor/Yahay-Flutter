import 'package:yahay/src/core/models/user_model/user_model.dart';

import 'add_contact_source.dart';

abstract class AddContactRepo {
  Future<List<UserModel>> searchContact(String value, int page);

  Future<bool> addContact(UserModel? user);
}

class AddContactRepoImpl extends AddContactRepo {
  final AddContactSource _addContactSource;

  AddContactRepoImpl(this._addContactSource);

  @override
  Future<List<UserModel>> searchContact(String value, int page) =>
      _addContactSource.searchContact(value, page);

  @override
  Future<bool> addContact(UserModel? user) =>
      _addContactSource.addContact(user);
}
