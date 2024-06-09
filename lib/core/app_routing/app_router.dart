import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yahay/core/global_data/entities/chats_entities/chat.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/features/authorization/view/pages/login_page.dart';
import 'package:yahay/features/authorization/view/pages/register_page.dart';
import 'package:yahay/features/chat_screen/view/pages/chat_screen.dart';
import 'package:yahay/features/chats/view/pages/chats_page.dart';
import 'package:yahay/features/home_page.dart';
import 'package:yahay/features/loading_page.dart';
import 'package:yahay/features/video_chat_feature/view/pages/video_chat_feature_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
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
