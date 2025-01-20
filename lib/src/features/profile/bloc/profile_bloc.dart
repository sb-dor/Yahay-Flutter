import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import 'state_model/profile_state_model.dart';

part 'profile_bloc.freezed.dart';

// @immutable
// class ProfileBloc {
//   static late ProfileStateModel _currentStateModel;
//   static late BehaviorSubject<ProfileStates> _currentState;
//
//   final Sink<ProfileEvents> events;
//   final BehaviorSubject<ProfileStates> _states;
//
//   const ProfileBloc._({
//     required this.events,
//     required BehaviorSubject<ProfileStates> states,
//   }) : _states = states;
//
//   factory ProfileBloc() {
//     _currentStateModel = ProfileStateModel();
//
//     final eventsBehavior = BehaviorSubject<ProfileEvents>();
//
//     final state = eventsBehavior.switchMap<ProfileStates>((events) async* {
//       yield* _eventHandler(events);
//     }).startWith(LoadingProfileState(_currentStateModel));
//
//     final stateBehavior = BehaviorSubject<ProfileStates>()..addStream(state);
//
//     _currentState = stateBehavior;
//
//     return ProfileBloc._(
//       events: eventsBehavior.sink,
//       states: stateBehavior,
//     );
//   }
//
//   static Stream<ProfileStates> _eventHandler(ProfileEvents event) async* {
//     if (event is ProfileLogoutEvent) {
//       yield* _profileLogoutEvent(event);
//     }
//   }
//
//   static Stream<ProfileStates> _profileLogoutEvent(ProfileLogoutEvent event) async* {
//     try {
//       event.logoutEvent();
//     } catch (e) {
//       debugPrint("_profileLogoutEvent error is: $e");
//     }
//   }
// }

@immutable
@freezed
class ProfileEvents with _$ProfileEvents {
  const factory ProfileEvents.profileLogoutEvent(final void Function() logoutEvent) =
      _ProfileLogoutEvent;
}

@immutable
@freezed
class ProfileStates with _$ProfileStates {
  const factory ProfileStates.initial(final ProfileStateModel profileStateModel) =
      InitialProfileState;

  const factory ProfileStates.loadingProfileState(final ProfileStateModel profileStateModel) =
      LoadingProfileState;

  const factory ProfileStates.errorProfileState(final ProfileStateModel profileStateModel) =
      ErrorProfileState;

  const factory ProfileStates.loadedProfileState(final ProfileStateModel profileStateModel) =
      LoadedProfileState;
}

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  //
  ProfileBloc({
    required final ProfileStates initialState,
  }) : super(initialState);
}
