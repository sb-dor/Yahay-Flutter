import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:yahay/features/authorization/view/pages/login_page.dart';
import 'package:yahay/features/authorization/view/pages/register_page.dart';
import 'package:yahay/features/chats/view/chats_page.dart';
import 'package:yahay/features/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
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
      ];
}
