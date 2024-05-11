import 'package:flutter/foundation.dart';

@immutable
class AddContactsEvents {}

@immutable
class SearchContactEvent extends AddContactsEvents {
  final String value;

  SearchContactEvent(this.value);
}

@immutable
class AddContactEvent extends AddContactsEvents {}

@immutable
class ClearDataEvent extends AddContactsEvents {}
