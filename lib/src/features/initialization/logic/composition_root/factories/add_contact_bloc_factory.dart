import 'package:logger/logger.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';
import 'package:yahay/src/features/add_contact_feature/bloc/add_contact_bloc.dart';
import 'package:yahay/src/features/add_contact_feature/bloc/state_model/add_contact_state_model.dart';
import 'package:yahay/src/features/add_contact_feature/data/add_contact_source.dart';
import 'package:yahay/src/features/add_contact_feature/data/add_contact_repo.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';

final class AddContactBlocFactory extends Factory<AddContactBloc> {
  //

  AddContactBlocFactory({
    required final Logger logger,
    required final RestClientBase restClientBase,
  })  : _logger = logger,
        _restClientBase = restClientBase;

  final Logger _logger;
  final RestClientBase _restClientBase;

  @override
  AddContactBloc create() {
    //
    final AddContactSource addContactSource = AddContactSourceImpl(
      logger: _logger,
      restClientBase: _restClientBase,
    );

    final AddContactRepo addContactRepo = AddContactRepoImpl(addContactSource);

    final initialState = AddContactsStates.initial(AddContactStateModel.idle());

    return AddContactBloc(
      initialState: initialState,
      iAddContactRepo: addContactRepo,
    );
  }
}
