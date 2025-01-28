import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/src/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/add_contact_bloc_factory.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/authorization_bloc_factory.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/profile_bloc_factory.dart';
import 'package:yahay/src/features/initialization/models/dependency_container.dart';

final class CompositionRoot extends AsyncFactory<CompositionResult> {
  //

  CompositionRoot({
    required Logger logger,
    required SharedPreferHelper sharedPreferHelper,
    required DioSettings dioSettings,
  })  : _logger = logger,
        _sharedPreferHelper = sharedPreferHelper,
        _dioSettings = dioSettings;

  final Logger _logger;
  final SharedPreferHelper _sharedPreferHelper;
  final DioSettings _dioSettings;

  @override
  Future<CompositionResult> create() async {
    final dependencyContainer = await DependencyContainerFactory(
      logger: _logger,
      sharedPreferHelper: _sharedPreferHelper,
      dioSettings: _dioSettings,
    ).create();

    return CompositionResult(dependencyContainer);
  }
}

class CompositionResult {
  final DependencyContainer dependencies;

  CompositionResult(this.dependencies);
}

final class DependencyContainerFactory extends AsyncFactory<DependencyContainer> {
  DependencyContainerFactory({
    required Logger logger,
    required SharedPreferHelper sharedPreferHelper,
    required DioSettings dioSettings,
  })  : _logger = logger,
        _sharedPreferHelper = sharedPreferHelper,
        _dioSettings = dioSettings;

  final Logger _logger;
  final SharedPreferHelper _sharedPreferHelper;
  final DioSettings _dioSettings;

  @override
  Future<DependencyContainer> create() async {
    final authBloc = AuthorizationBlocFactory(
      googleSignIn: GoogleSignIn(),
      facebookAuth: FacebookAuth.instance,
      sharedPreferHelper: _sharedPreferHelper,
    ).create();

    final cameraHelperService = CameraHelperService();
    await cameraHelperService.initCameras();

    final profileBloc = ProfileBlocFactory().create();

    final addContactBloc = AddContactBlocFactory(
      logger: _logger,
    ).create();

    final pusherClientService = PusherClientService();

    await pusherClientService.init();

    return DependencyContainer(
      logger: _logger,
      sharedPreferHelper: _sharedPreferHelper,
      dioSettings: _dioSettings,
      appThemeBloc: AppThemeBloc(),
      authBloc: authBloc,
      profileBloc: profileBloc,
      addContactBloc: addContactBloc,
      appRouter: AppRouter(),
      pusherClientService: pusherClientService,
      cameraHelperService: cameraHelperService,
    );
  }
}

abstract base class Factory<T> {
  T create();
}

abstract base class AsyncFactory<T> {
  Future<T> create();
}
