import 'package:logger/logger.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/app_settings/app_theme/app_theme_bloc.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/chat_screen/view/bloc/chat_screen_bloc.dart';
import 'package:yahay/features/chats/view/bloc/chats_bloc.dart';
import 'package:yahay/features/profile/view/bloc/profile_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/injections/blocs_inj/video_chat_bloc_inj/video_chat_bloc_inj.dart';

class DependencyContainer {
  //
  final Logger logger;

  final AppThemeBloc appThemeBloc;

  final AuthBloc authBloc;

  final ChatsBloc chatsBloc;

  final ProfileBloc profileBloc;

  final VideoChatBlocInj videoChatBlocInj;

  final AppRouter appRouter;

  DependencyContainer({
    required this.logger,
    required this.appThemeBloc,
    required this.authBloc,
    required this.chatsBloc,
    required this.profileBloc,
    required this.videoChatBlocInj,
    required this.appRouter,
  });
}
