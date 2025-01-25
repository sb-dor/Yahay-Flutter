import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'state_model/profile_state_model.dart';

part 'profile_bloc.freezed.dart';

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
  }) : super(initialState) {
    on<ProfileEvents>(
      (event, emit) => event.map(
        profileLogoutEvent: (event) => _profileLogoutEvent(event, emit),
      ),
    );
  }

  void _profileLogoutEvent(
    _ProfileLogoutEvent event,
    Emitter<ProfileStates> emit,
  ) async {}
}
