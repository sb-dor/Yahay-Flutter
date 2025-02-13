import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'state_model/profile_state_model.dart';

part 'profile_bloc.freezed.dart';

@immutable
@freezed
class ProfileEvents with _$ProfileEvents {
  const factory ProfileEvents.profileLogoutEvent(final void Function() logoutEvent) =
      _Profile$LogoutEvent;
}

@immutable
@freezed
class ProfileStates with _$ProfileStates {
  const factory ProfileStates.initial(final ProfileStateModel profileStateModel) =
      InitialProfileState;

  const factory ProfileStates.inProgress(final ProfileStateModel profileStateModel) =
      Profile$InProgressState;

  const factory ProfileStates.error(final ProfileStateModel profileStateModel) =
      Profile$ErrorState;

  const factory ProfileStates.successful(final ProfileStateModel profileStateModel) =
      Profile$SuccessfulState;
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
    _Profile$LogoutEvent event,
    Emitter<ProfileStates> emit,
  ) async {}
}
