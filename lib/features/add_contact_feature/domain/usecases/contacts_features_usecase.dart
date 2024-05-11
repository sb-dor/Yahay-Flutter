import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/add_contact_feature/domain/repo/add_contact_repo.dart';

class ContactsFeaturesFunctions {
  final AddContactRepo _addContactRepo;

  ContactsFeaturesFunctions(this._addContactRepo);

  Future<List<User>?> searchContact(String value, int page) =>
      _addContactRepo.searchContact(value, page);

  Future<bool> addContact(User? user) => _addContactRepo.addContact(user);
}
