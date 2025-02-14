import 'package:logger/logger.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/src/features/profile/bloc/profile_bloc.dart';
import 'package:yahay/src/features/profile/bloc/state_model/profile_state_model.dart';
import 'package:yahay/src/features/profile/data/profile_datasource.dart';
import 'package:yahay/src/features/profile/data/profile_repository.dart';

final class ProfileBlocFactory extends Factory<ProfileBloc> {
  //
  ProfileBlocFactory({
    required final Logger logger,
    required final RestClientBase restClientBase,
  })  : _logger = logger,
        _restClientBase = restClientBase;

  final Logger _logger;
  final RestClientBase _restClientBase;

  @override
  ProfileBloc create() {
    final IProfileDatasource profileDatasource = ProfileDatasourceImpl(
      logger: _logger,
      restClientBase: _restClientBase,
    );

    final IProfileRepository profileRepository = ProfileRepositoryImpl(profileDatasource);

    //
    final initialState = ProfileStates.initial(ProfileStateModel());

    return ProfileBloc(
      initialState: initialState,
      iProfileRepository: profileRepository,
    );
  }
}
