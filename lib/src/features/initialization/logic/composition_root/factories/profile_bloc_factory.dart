import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/src/features/profile/bloc/profile_bloc.dart';
import 'package:yahay/src/features/profile/bloc/state_model/profile_state_model.dart';

final class ProfileBlocFactory extends Factory<ProfileBloc> {
  @override
  ProfileBloc create() {
    //
    final initialState = ProfileStates.initial(ProfileStateModel());

    return ProfileBloc(
      initialState: initialState,
    );
  }
}
