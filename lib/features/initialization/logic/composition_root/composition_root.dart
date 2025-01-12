import 'package:logger/logger.dart';
import 'package:yahay/core/app_routing/app_router.dart';
import 'package:yahay/core/utils/pusher_client_service/pusher_client_service.dart';
import 'package:yahay/core/utils/shared_preferences/shared_preferences.dart';
import 'package:yahay/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/features/initialization/logic/composition_root/factories/add_contact_bloc_factory.dart';
import 'package:yahay/features/initialization/logic/composition_root/factories/authorization_bloc_factory.dart';
import 'package:yahay/features/initialization/logic/composition_root/factories/chats_bloc_factory.dart';
import 'package:yahay/features/initialization/logic/composition_root/factories/profile_bloc_factory.dart';
import 'package:yahay/features/initialization/models/dependency_container.dart';

final class CompositionRoot extends AsyncFactory<CompositionResult> {
  //
  final Logger _logger;

  CompositionRoot({required Logger logger}) : _logger = logger;

  @override
  Future<CompositionResult> create() async {
    final dependencyContainer = await DependencyContainerFactory(
      logger: _logger,
    ).create();

    return CompositionResult(dependencyContainer);
  }
}

class CompositionResult {
  final DependencyContainer dependencies;

  CompositionResult(this.dependencies);
}

final class DependencyContainerFactory extends AsyncFactory<DependencyContainer> {
  DependencyContainerFactory({required Logger logger}) : _logger = logger;

  final Logger _logger;

  @override
  Future<DependencyContainer> create() async {
    final authBloc = AuthorizationBlocFactory().create();

    final chatsBloc = ChatsBlocFactory().create();

    final profileBloc = ProfileBlocFactory().create();

    final addContactBloc = AddContactBlocFactory().create();

    final sharedPreferences = SharedPreferHelper();

    await sharedPreferences.initSharedPrefer();

    final pusherClientService = PusherClientService();

    await pusherClientService.init();

    return DependencyContainer(
      logger: _logger,
      appThemeBloc: AppThemeBloc(),
      authBloc: authBloc,
      chatsBloc: chatsBloc,
      profileBloc: profileBloc,
      addContactBloc: addContactBloc,
      appRouter: AppRouter(),
      sharedPreferHelper: sharedPreferences,
      pusherClientService: pusherClientService,
    );
  }
}

abstract base class Factory<T> {
  T create();
}

abstract base class AsyncFactory<T> {
  Future<T> create();
}
