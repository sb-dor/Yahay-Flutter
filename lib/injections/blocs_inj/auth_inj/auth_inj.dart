import 'package:yahay/features/authorization/data/repo/authorization_repo_impl.dart';
import 'package:yahay/features/authorization/data/repo/other_authorization_repo_impl.dart';
import 'package:yahay/features/authorization/data/sources/laravel/impl/laravel_auth_data_source_impl.dart';
import 'package:yahay/features/authorization/data/sources/laravel/laravel_auth_data_source.dart';
import 'package:yahay/features/authorization/data/sources/other_authorization/impl/other_authorization_impl.dart';
import 'package:yahay/features/authorization/data/sources/other_authorization/other_authorization.dart';
import 'package:yahay/features/authorization/domain/repo/authorization_repo.dart';
import 'package:yahay/features/authorization/domain/repo/other_authorization_repo.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class AuthInj {
  static Future<void> authInj() async {
    snoopy.registerLazySingleton<LaravelAuthDataSource>(
      () => LaravelAuthDataSourceImpl(),
    );

    snoopy.registerLazySingleton<AuthorizationRepo>(
      () => AuthorizationRepoImpl(snoopy<LaravelAuthDataSource>()),
    );

    snoopy.registerLazySingleton<OtherAuthorization>(
      () => OtherAuthorizationImpl(),
    );

    snoopy.registerLazySingleton<OtherAuthorizationRepo>(
      () => OtherAuthorizationRepoImpl(
        snoopy<OtherAuthorization>(),
      ),
    );

    snoopy.registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        authorizationRepo: snoopy<AuthorizationRepo>(),
        otherAuthorizationRepo: snoopy<OtherAuthorizationRepo>(),
      ),
    );
  }
}
