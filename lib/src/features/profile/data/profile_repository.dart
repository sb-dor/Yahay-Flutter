import 'package:yahay/src/features/profile/data/profile_datasource.dart';

abstract interface class IProfileRepository {}

final class ProfileRepositoryImpl implements IProfileRepository {
  //

  ProfileRepositoryImpl(this._iProfileDatasource);

  final IProfileDatasource _iProfileDatasource;


}
