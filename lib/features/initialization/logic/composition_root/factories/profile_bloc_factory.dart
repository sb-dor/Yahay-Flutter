import 'package:yahay/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/features/profile/view/bloc/profile_bloc.dart';

final class ProfileBlocFactory extends Factory<ProfileBloc> {
  @override
  ProfileBloc create() {
    return ProfileBloc();
  }
}
