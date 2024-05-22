import 'package:yahay/features/profile/view/bloc/profile_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class ProfileBlocInj {
  static Future<void> profileBlocInj() async {
    snoopy.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
  }
}
