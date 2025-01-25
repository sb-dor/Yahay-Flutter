// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ChatScreen]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    required ChatModel? chat,
    required UserModel? user,
    List<PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(key: key, chat: chat, user: user),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return ChatScreen(key: args.key, chat: args.chat, user: args.user);
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, required this.chat, required this.user});

  final Key? key;

  final ChatModel? chat;

  final UserModel? user;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, chat: $chat, user: $user}';
  }
}

/// generated route for
/// [ChatsPage]
class ChatsRoute extends PageRouteInfo<void> {
  const ChatsRoute({List<PageRouteInfo>? children})
    : super(ChatsRoute.name, initialChildren: children);

  static const String name = 'ChatsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChatsPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LoadingPage]
class LoadingRoute extends PageRouteInfo<void> {
  const LoadingRoute({List<PageRouteInfo>? children})
    : super(LoadingRoute.name, initialChildren: children);

  static const String name = 'LoadingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoadingPage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterPage();
    },
  );
}

/// generated route for
/// [VideoChatFeaturePage]
class VideoChatFeatureRoute extends PageRouteInfo<VideoChatFeatureRouteArgs> {
  VideoChatFeatureRoute({
    Key? key,
    required ChatModel? chat,
    List<PageRouteInfo>? children,
  }) : super(
         VideoChatFeatureRoute.name,
         args: VideoChatFeatureRouteArgs(key: key, chat: chat),
         initialChildren: children,
       );

  static const String name = 'VideoChatFeatureRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoChatFeatureRouteArgs>();
      return VideoChatFeaturePage(key: args.key, chat: args.chat);
    },
  );
}

class VideoChatFeatureRouteArgs {
  const VideoChatFeatureRouteArgs({this.key, required this.chat});

  final Key? key;

  final ChatModel? chat;

  @override
  String toString() {
    return 'VideoChatFeatureRouteArgs{key: $key, chat: $chat}';
  }
}
