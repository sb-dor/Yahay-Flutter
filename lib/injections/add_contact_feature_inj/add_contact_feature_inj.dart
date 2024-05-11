import 'package:yahay/features/add_contact_feature/data/repo/add_contact_repo_impl.dart';
import 'package:yahay/features/add_contact_feature/data/sources/add_contact_source/add_contact_source.dart';
import 'package:yahay/features/add_contact_feature/data/sources/add_contact_source/impl/add_contact_source_impl.dart';
import 'package:yahay/features/add_contact_feature/domain/repo/add_contact_repo.dart';
import 'package:yahay/features/add_contact_feature/view/bloc/add_contact_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class AddContactFeatureInj {
  static Future<void> addContactFeatureInj() async {
    snoopy.registerLazySingleton<AddContactSource>(() => AddContactSourceImpl());

    snoopy.registerLazySingleton<AddContactRepo>(
      () => AddContactRepoImpl(
        snoopy<AddContactSource>(),
      ),
    );

    snoopy.registerLazySingleton<AddContactBloc>(
      () => AddContactBloc(addContactRepo: snoopy<AddContactRepo>()),
    );
  }
}
