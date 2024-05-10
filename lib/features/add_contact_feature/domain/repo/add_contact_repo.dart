import 'package:yahay/core/global_data/entities/user.dart';

abstract class AddContactRepo {
  Future<List<User>?> searchContact(String value);

  Future<bool> addContact(User? user);
}
