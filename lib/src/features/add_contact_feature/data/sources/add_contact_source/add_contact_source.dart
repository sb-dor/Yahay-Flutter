import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/global_data/models/user_model/user_model.dart';

abstract class AddContactSource {
  Future<List<UserModel>> searchContact(String value, int page);

  Future<bool> addContact(User? user);
}
