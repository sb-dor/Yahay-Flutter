import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/add_contact_feature/domain/repo/add_contact_repo.dart';

class SearchContactUsecase {
  final AddContactRepo _addContactRepo;

  SearchContactUsecase(this._addContactRepo);

  Future<List<User>?> searchContact(String value) => _addContactRepo.searchContact(value);
}
