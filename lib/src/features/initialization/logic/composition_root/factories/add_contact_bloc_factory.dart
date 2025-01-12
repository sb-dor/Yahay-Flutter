import 'package:yahay/src/features/add_contact_feature/data/repo/add_contact_repo_impl.dart';
import 'package:yahay/src/features/add_contact_feature/data/sources/add_contact_source/add_contact_source.dart';
import 'package:yahay/src/features/add_contact_feature/data/sources/add_contact_source/impl/add_contact_source_impl.dart';
import 'package:yahay/src/features/add_contact_feature/domain/repo/add_contact_repo.dart';
import 'package:yahay/src/features/add_contact_feature/view/bloc/add_contact_bloc.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';

final class AddContactBlocFactory extends Factory<AddContactBloc> {
  @override
  AddContactBloc create() {
    //
    final AddContactSource addContactSource = AddContactSourceImpl();

    final AddContactRepo addContactRepo = AddContactRepoImpl(addContactSource);

    return AddContactBloc(addContactRepo: addContactRepo);
  }
}
