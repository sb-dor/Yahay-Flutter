import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/add_contact_feature/data/sources/add_contact_source/add_contact_source.dart';
import 'package:yahay/features/add_contact_feature/domain/repo/add_contact_repo.dart';

class AddContactRepoImpl extends AddContactRepo {
  final AddContactSource _addContactSource;

  AddContactRepoImpl(this._addContactSource);

  @override
  Future<List<User>?> searchContact(String value) => _addContactSource.searchContact(value);

  @override
  Future<bool> addContact(User? user) {
    // TODO: implement addContact
    throw UnimplementedError();
  }
}
