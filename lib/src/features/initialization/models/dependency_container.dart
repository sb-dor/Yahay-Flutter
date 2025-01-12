import 'package:logger/logger.dart';
import 'package:yahay/src/core/app_routing/app_router.dart';
import 'package:yahay/src/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/src/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/src/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/src/features/add_contact_feature/view/bloc/add_contact_bloc.dart';
import 'package:yahay/src/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/src/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/src/features/chats/view/bloc/chats_bloc.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/chats_bloc_factory.dart';
import 'package:yahay/src/features/profile/view/bloc/profile_bloc.dart';

class DependencyContainer {
  //
  final Logger logger;

  final AppThemeBloc appThemeBloc;

  final AuthBloc authBloc;

  final ProfileBloc profileBloc;

  final AddContactBloc addContactBloc;

  final AppRouter appRouter;

  final SharedPreferHelper sharedPreferHelper;

  final PusherClientService pusherClientService;

  final CameraHelperService cameraHelperService;

  ChatsBloc? chatsBloc;

  DependencyContainer({
    required this.logger,
    required this.appThemeBloc,
    required this.authBloc,
    required this.profileBloc,
    required this.addContactBloc,
    required this.appRouter,
    required this.sharedPreferHelper,
    required this.pusherClientService,
    required this.cameraHelperService,
  });

  void initChatBlocAfterAuthorization() {
    chatsBloc = ChatsBlocFactory(
      currentUser: authBloc.states.value.authStateModel.user,
      pusherChannelsOption: pusherClientService.options,
      logger: logger,
    ).create();
  }
}

// not included
// telegrampickerimage
// videochatbloc
// chatsscreenbloc
