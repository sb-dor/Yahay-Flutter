import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/features/add_contact_feature/data/add_contact_repo.dart';
import 'state_model/add_contact_state_model.dart';

part 'add_contact_bloc.freezed.dart';

@immutable
@freezed
class AddContactsEvents with _$AddContactsEvents {
  const factory AddContactsEvents.searchContact(final String value) = _SearchContactEvent;

  const factory AddContactsEvents.addContactEvent(final UserModel? user) =
      _AddContactEventOnAddContactsEvent;

  const factory AddContactsEvents.clearDataEvent() = _ClearDataEvent;
}

@immutable
@freezed
sealed class AddContactsStates with _$AddContactsStates {
  const factory AddContactsStates.initial(final AddContactStateModel addContactStateModel) =
      InitialAddConstactsState;

  const factory AddContactsStates.loadingAddContactsState(
      final AddContactStateModel addContactStateModel) = AddContacts$InProgressState;

  const factory AddContactsStates.errorAddContactsState(
      final AddContactStateModel addContactStateModel) = AddContacts$ErrorState;

  const factory AddContactsStates.loadedAddContactsState(
      final AddContactStateModel addContactStateModel) = AddContacts$SuccessfulState;
}

class AddContactBloc extends Bloc<AddContactsEvents, AddContactsStates> {
  final AddContactRepo _iAddContactRepo;

  AddContactBloc({
    required AddContactsStates initialState,
    required AddContactRepo iAddContactRepo,
  })  : _iAddContactRepo = iAddContactRepo,
        super(initialState) {
    on<AddContactsEvents>(
      (event, emit) => event.map(
        searchContact: (event) => _searchContactEvent(event, emit),
        addContactEvent: (event) => _addContactEventHandler(event, emit),
        clearDataEvent: (event) {
          var currentState = state.addContactStateModel.clearData();

          emit(AddContactsStates.loadedAddContactsState(currentState));
          return null;
        },
      ),
    );
  }

  void _searchContactEvent(
    _SearchContactEvent event,
    Emitter<AddContactsStates> emit,
  ) async {
    var currentStateModel = state.addContactStateModel.copyWith();

    try {
      if (event.value.trim().isEmpty) return;

      currentStateModel.clearData();
      //
      emit(AddContactsStates.loadingAddContactsState(currentStateModel));
      //
      final data = await _iAddContactRepo.searchContact(
        event.value,
        currentStateModel.page,
      );
      //

      final List<UserModel> currentUsers = List<UserModel>.from(currentStateModel.users);

      currentUsers.addAll(data);

      currentStateModel = currentStateModel.copyWith();
      //
      // // if yield has "*" it means that you will yield whole stream with value for returning stream
      // // if yield has not "*" it meant that you will yield only value for returning stream
      emit(AddContactsStates.loadedAddContactsState(currentStateModel));
    } catch (e) {
      emit(AddContactsStates.errorAddContactsState(currentStateModel));
    }
  }

  void _addContactEventHandler(
    _AddContactEventOnAddContactsEvent event,
    Emitter<AddContactsStates> emit,
  ) async {
    var currentStateModel = state.addContactStateModel.copyWith();

    // try {
    if (event.user == null) return;

    UserModel? changingModel = event.user?.copyWith(
      loadingForAddingToContacts: true,
    );

    List<UserModel> tempUsersList = List<UserModel>.from(currentStateModel.users);

    final foundIndex = tempUsersList.indexWhere((el) => el.id == event.user?.id);

    if (foundIndex != -1) {
      tempUsersList[foundIndex] = event.user!;
    }

    final responseValue = await _iAddContactRepo.addContact(event.user);

    debugPrint("reponse value: $responseValue");

    changingModel = changingModel?.copyWith(
      loadingForAddingToContacts: false,
    );

    if (foundIndex != -1) {
      tempUsersList[foundIndex] = event.user!;
    }

    if (!responseValue) return;

    // set temp user. means that user successfully added this user to his contacts
    changingModel = changingModel?.copyWith(contact: UserModel());

    if (foundIndex != -1) {
      tempUsersList[foundIndex] = event.user!;
    }

    currentStateModel = currentStateModel.copyWith(users: tempUsersList);

    emit(AddContactsStates.loadedAddContactsState(currentStateModel));

    // } catch (e) {
    //   yield AddContacts$ErrorState(_currentStateModel);
    // }
  }
}
