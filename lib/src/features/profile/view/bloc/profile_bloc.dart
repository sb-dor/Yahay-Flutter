import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yahay/src/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/src/features/authorization/view/bloc/auth_events.dart';
import 'package:yahay/src/features/profile/view/bloc/state_model/profile_state_model.dart';

import 'profile_events.dart';
import 'profile_states.dart';

@immutable
class ProfileBloc {
  static late ProfileStateModel _currentStateModel;
  static late BehaviorSubject<ProfileStates> _currentState;

  final Sink<ProfileEvents> events;
  final BehaviorSubject<ProfileStates> _states;

  const ProfileBloc._({
    required this.events,
    required BehaviorSubject<ProfileStates> states,
  }) : _states = states;

  factory ProfileBloc() {
    _currentStateModel = ProfileStateModel();

    final eventsBehavior = BehaviorSubject<ProfileEvents>();

    final state = eventsBehavior.switchMap<ProfileStates>((events) async* {
      yield* _eventHandler(events);
    }).startWith(LoadingProfileState(_currentStateModel));

    final stateBehavior = BehaviorSubject<ProfileStates>()..addStream(state);

    _currentState = stateBehavior;

    return ProfileBloc._(
      events: eventsBehavior.sink,
      states: stateBehavior,
    );
  }

  static Stream<ProfileStates> _eventHandler(ProfileEvents event) async* {
    if (event is ProfileLogoutEvent) {
      yield* _profileLogoutEvent(event);
    }
  }

  static Stream<ProfileStates> _profileLogoutEvent(ProfileLogoutEvent event) async* {
    try {
      event.logoutEvent();
    } catch (e) {
      debugPrint("_profileLogoutEvent error is: $e");
    }
  }
}
