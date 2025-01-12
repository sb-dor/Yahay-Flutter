import 'package:yahay/features/authorization/data/repo/authorization_repo_impl.dart';
import 'package:yahay/features/authorization/data/repo/other_authorization_repo_impl.dart';
import 'package:yahay/features/authorization/data/sources/laravel/impl/laravel_auth_data_source_impl.dart';
import 'package:yahay/features/authorization/data/sources/laravel/laravel_auth_data_source.dart';
import 'package:yahay/features/authorization/data/sources/other_authorization/impl/other_authorization_impl.dart';
import 'package:yahay/features/authorization/data/sources/other_authorization/other_authorization.dart';
import 'package:yahay/features/authorization/domain/repo/authorization_repo.dart';
import 'package:yahay/features/authorization/domain/repo/other_authorization_repo.dart';
import 'package:yahay/features/authorization/view/bloc/auth_bloc.dart';
import 'package:yahay/features/initialization/logic/composition_root/composition_root.dart';

final class AuthorizationBlocFactory extends Factory<AuthBloc> {
  @override
  AuthBloc create() {
    final LaravelAuthDataSource laravelAuthDataSource = LaravelAuthDataSourceImpl();

    final OtherAuthorizationDatasource otherAuthorizationDatasource = OtherAuthorizationImpl();

    final AuthorizationRepo authorizationRepo = AuthorizationRepoImpl(laravelAuthDataSource);

    final OtherAuthorizationRepo otherAuthorizationRepo = OtherAuthorizationRepoImpl(
      otherAuthorizationDatasource,
    );

    return AuthBloc(
      authorizationRepo: authorizationRepo,
      otherAuthorizationRepo: otherAuthorizationRepo,
    );
  }
}
