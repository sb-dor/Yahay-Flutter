import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/src/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/src/features/add_contact_feature/domain/repo/add_contact_repo.dart';
import 'package:yahay/src/features/add_contact_feature/domain/usecases/contacts_features_usecase.dart';
import 'add_contacts_events.dart';
import 'add_contacts_states.dart';
import 'state_model/add_contact_state_model.dart';

@immutable
class AddContactBloc {
  static late AddContactStateModel _currentStateModel;
  static late BehaviorSubject<AddContactsStates> _currentState; // for emitter (if it's necessary)
  static late AddContactRepo _addContactRepo;
  static late ContactsFeaturesFunctions _contactsFeaturesFunctions;

  final Sink<AddContactsEvents> event;
  final Sink<SearchContactEvent> onlySearchContactEvent;
  final BehaviorSubject<AddContactsStates> _state;

  Stream<AddContactsStates> get state => _state.stream;

  const AddContactBloc._({
    required this.event,
    required this.onlySearchContactEvent,
    required BehaviorSubject<AddContactsStates> state,
  }) : _state = state;

  factory AddContactBloc({
    required AddContactRepo addContactRepo,
  }) {
    _addContactRepo = addContactRepo;
    _contactsFeaturesFunctions = ContactsFeaturesFunctions(_addContactRepo);
    _currentStateModel = AddContactStateModel();

    final eventsBehavior = BehaviorSubject<AddContactsEvents>();

    final searchEventBehavior = BehaviorSubject<SearchContactEvent>();

    final state = eventsBehavior.switchMap<AddContactsStates>((event) async* {
      // if yield has "*" it means that you will yield whole stream with value for returning stream
      // if yield has not "*" it meant that you will yield only value for returning stream
      yield* _eventHandler(event);
    }).startWith(LoadedAddContactsState(_currentStateModel));

    final onlySearchEventStream = searchEventBehavior
        .distinct()
        .debounceTime(const Duration(seconds: 1))
        .switchMap<AddContactsStates>((value) async* {
      // if yield has "*" it means that you will yield whole stream with value for returning stream
      // if yield has not "*" it meant that you will yield only value for returning stream
      yield* _searchContactEvent(value);
    });

    final mergedStreams = Rx.merge([state, onlySearchEventStream]);

    final stateBehavior = BehaviorSubject<AddContactsStates>()..addStream(mergedStreams);

    _currentState = stateBehavior;

    return AddContactBloc._(
      event: eventsBehavior.sink,
      onlySearchContactEvent: searchEventBehavior.sink,
      state: stateBehavior,
    );
  }

  static Stream<AddContactsStates> _eventHandler(AddContactsEvents event) async* {
    Stream<AddContactsStates> tempStream = Stream.value(LoadedAddContactsState(_currentStateModel));

    if (event is AddContactEvent) {
      tempStream = _addContactEvent(event);
    } else if (event is ClearDataEvent) {
      _currentStateModel.clearData();
      tempStream = _emitter();
    }

    // if yield has "*" it means that you will yield whole stream with value for returning stream
    // if yield has not "*" it meant that you will yield only value for returning stream
    yield* tempStream;
  }

  static Stream<AddContactsStates> _searchContactEvent(SearchContactEvent event) async* {
    try {
      if (event.value.trim().isEmpty) return;

      _currentStateModel.clearData();

      yield LoadingAddContactsState(_currentStateModel);

      final data = await _contactsFeaturesFunctions.searchContact(
        event.value,
        _currentStateModel.page,
      );

      _currentStateModel.addAndPag(data ?? []);

      // if yield has "*" it means that you will yield whole stream with value for returning stream
      // if yield has not "*" it meant that you will yield only value for returning stream
      yield LoadedAddContactsState(_currentStateModel);
    } catch (e) {
      yield ErrorAddContactsState(_currentStateModel);
    }
  }

  static Stream<AddContactsStates> _addContactEvent(AddContactEvent event) async* {
    try {
      if (event.user == null) return;

      UserModel? changingModel = UserModel.fromEntity(event.user!)?.copyWith(
        loadingForAddingToContacts: true,
      );

      _currentStateModel.setChangedModel(changingModel);

      yield* _emitter();

      final responseValue = await _contactsFeaturesFunctions.addContact(event.user);

      debugPrint("reponse value: $responseValue");

      changingModel = changingModel?.copyWith(
        loadingForAddingToContacts: false,
      );

      _currentStateModel.setChangedModel(changingModel);

      yield* _emitter();

      if (!responseValue) return;

      // set temp user. means that user successfully added this user to his contacts
      changingModel = changingModel?.copyWith(contact: UserModel());

      _currentStateModel.setChangedModel(changingModel);

      yield* _emitter();
    } catch (e) {
      yield ErrorAddContactsState(_currentStateModel);
    }
  }

  static Stream<AddContactsStates> _emitter() async* {
    if (_currentState.value is LoadingAddContactsState) {
      yield LoadingAddContactsState(_currentStateModel);
    } else if (_currentState.value is ErrorAddContactsState) {
      yield ErrorAddContactsState(_currentStateModel);
    } else if (_currentState.value is LoadedAddContactsState) {
      yield LoadedAddContactsState(_currentStateModel);
    }
  }
}
