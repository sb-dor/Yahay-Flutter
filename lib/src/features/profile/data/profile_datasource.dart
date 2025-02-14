import 'package:logger/logger.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';

abstract interface class IProfileDatasource {}

final class ProfileDatasourceImpl implements IProfileDatasource {
  //
  ProfileDatasourceImpl({
    required final Logger logger,
    required final RestClientBase restClientBase,
  })  : _logger = logger,
        _restClientBase = restClientBase;

  final Logger _logger;
  final RestClientBase _restClientBase;
}
