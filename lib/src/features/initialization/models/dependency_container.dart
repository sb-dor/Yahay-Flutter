import 'package:logger/logger.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';
import 'package:yahay/src/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/features/add_contact_feature/bloc/add_contact_bloc.dart';
import 'package:yahay/src/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/src/features/authorization/bloc/auth_bloc.dart';
import 'package:yahay/src/features/chats/bloc/chats_bloc.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/chats_bloc_factory.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/profile_bloc_factory.dart';
import 'package:yahay/src/features/initialization/models/application_config.dart';
import 'package:yahay/src/features/profile/bloc/profile_bloc.dart';

class DependencyContainer {
  //

  DependencyContainer({
    required this.logger,
    required this.appThemeBloc,
    required this.authBloc,
    required this.addContactBloc,
    required this.appRouter,
    required this.sharedPreferHelper,
    required this.pusherClientService,
    required this.cameraHelperService,
    required this.restClientBase,
    required this.applicationConfig,
  });

  final Logger logger;

  final AppThemeBloc appThemeBloc;

  final AuthBloc authBloc;

  final AddContactBloc addContactBloc;

  final AppRouter appRouter;

  final SharedPreferHelper sharedPreferHelper;

  final PusherClientService pusherClientService;

  final CameraHelperService cameraHelperService;

  final RestClientBase restClientBase;

  final ApplicationConfig applicationConfig;

  ChatsBloc? chatsBloc;

  ProfileBloc? profileBloc;

  void initDependenciesAfterAuthorization() {
    chatsBloc =
        ChatsBlocFactory(
          currentUser: authBloc.state.authStateModel.user,
          pusherChannelsOption: pusherClientService.options,
          logger: logger,
          restClientBase: restClientBase,
        ).create();

    profileBloc = ProfileBlocFactory(logger: logger, restClientBase: restClientBase).create();
  }
}

// not included
// telegrampickerimage
// videochatbloc
// chatsscreenbloc
