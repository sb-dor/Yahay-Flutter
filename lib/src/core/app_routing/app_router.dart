import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/features/authorization/view/login_page.dart';
import 'package:yahay/src/features/authorization/view/register_page.dart';
import 'package:yahay/src/features/chat_screen/view/chat_screen.dart';
import 'package:yahay/src/features/chats/bloc/chats_bloc.dart';
import 'package:yahay/src/features/chats/view/chats_page.dart';
import 'package:yahay/src/features/home_page.dart';
import 'package:yahay/src/features/loading_page.dart';
import 'package:yahay/src/features/video_chat_feature/widgets/video_chat_feature_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoadingRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
        ),
        AutoRoute(
          page: RegisterRoute.page,
          path: '/register',
        ),
        AutoRoute(
          page: ChatsRoute.page,
          path: '/chats',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/homepage',
        ),
        AutoRoute(
          page: ChatRoute.page,
          path: "/homepage/chat/screen",
        ),
        AutoRoute(
          page: VideoChatFeatureRoute.page,
          path: '/videochat',
        ),
      ];
}
