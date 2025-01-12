import 'package:logger/logger.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/features/add_contact_feature/view/bloc/add_contact_bloc.dart';
import 'package:yahay/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/chats/view/bloc/chats_bloc.dart';
import 'package:yahay/features/profile/view/bloc/profile_bloc.dart';

class DependencyContainer {
  //
  final Logger logger;

  final AppThemeBloc appThemeBloc;

  final AuthBloc authBloc;

  final ChatsBloc chatsBloc;

  final ProfileBloc profileBloc;

  final AddContactBloc addContactBloc;

  final AppRouter appRouter;

  final SharedPreferHelper sharedPreferHelper;

  final PusherClientService pusherClientService;

  DependencyContainer({
    required this.logger,
    required this.appThemeBloc,
    required this.authBloc,
    required this.chatsBloc,
    required this.profileBloc,
    required this.addContactBloc,
    required this.appRouter,
    required this.sharedPreferHelper,
    required this.pusherClientService,
  });
}

// not included
// telegrampickerimage
// videochatbloc
// chatsscreenbloc
