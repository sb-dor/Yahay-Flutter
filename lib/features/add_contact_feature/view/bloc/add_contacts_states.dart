import 'package:flutter/foundation.dart';

import 'state_model/add_contact_state_model.dart';

@immutable
class AddContactsStates {
  final AddContactStateModel addContactStateModel;

  const AddContactsStates(this.addContactStateModel);
}

@immutable
class LoadingAddContactsState extends AddContactsStates {
  const LoadingAddContactsState(super.addContactStateModel);
}

@immutable
class ErrorAddContactsState extends AddContactsStates {
  const ErrorAddContactsState(super.addContactStateModel);
}

@immutable
class LoadedAddContactsState extends AddContactsStates {
  const LoadedAddContactsState(super.addContactStateModel);
}
