import 'package:flutter/foundation.dart';
import 'package:yahay/core/global_data/entities/user.dart';

@immutable
class AddContactsEvents {}

@immutable
class SearchContactEvent extends AddContactsEvents {
  final String value;

  SearchContactEvent(this.value);
}

@immutable
class AddContactEvent extends AddContactsEvents {
  final User? user;

  AddContactEvent(this.user);
}

@immutable
class ClearDataEvent extends AddContactsEvents {}
