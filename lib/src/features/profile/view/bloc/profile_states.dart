import 'package:flutter/foundation.dart';
import 'package:yahay/src/features/profile/view/bloc/state_model/profile_state_model.dart';

@immutable
class ProfileStates {
  final ProfileStateModel profileStateModel;

  const ProfileStates(this.profileStateModel);
}

@immutable
class LoadingProfileState extends ProfileStates {
  const LoadingProfileState(super.profileStateModel);
}

@immutable
class ErrorProfileState extends ProfileStates {
  const ErrorProfileState(super.profileStateModel);
}

@immutable
class LoadedProfileState extends ProfileStates {
  const LoadedProfileState(super.profileStateModel);
}
