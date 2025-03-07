import 'package:logger/logger.dart';
import 'package:yahay/src/core/utils/dio/src/http_routes/http_routes.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';
import 'package:yahay/src/core/utils/extensions/extensions.dart';

abstract class AddContactSource {
  Future<List<UserModel>> searchContact(String value, int page);

  Future<bool> addContact(UserModel? user);
}

class AddContactSourceImpl implements AddContactSource {
  //
  AddContactSourceImpl({
    required final Logger logger,
    required final RestClientBase restClientBase,
  }) : _logger = logger,
       _restClientBase = restClientBase;

  final Logger _logger;

  final RestClientBase _restClientBase;

  final String _searchContactUrl = "${HttpRoutes.contactsPrefix}/search";

  final String _addContactUrl = "${HttpRoutes.contactsPrefix}/add-contact";

  @override
  Future<List<UserModel>> searchContact(String value, int page) async {
    try {
      final response = await _restClientBase.get(
        _searchContactUrl,
        queryParams: {"value": value.trim(), "page": page.toString()},
      );

      if (response == null) return <UserModel>[];

      _logger.log(Level.debug, "users search response: $response");

      if (!response.containsKey("success")) return <UserModel>[];

      final List<dynamic> usersList = response.getNested(['users', 'data']);

      final userList = usersList.map((e) => UserModel.fromJson(e)).toList();

      return userList;
    } on RestClientException {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<bool> addContact(UserModel? user) async {
    try {
      final body = {"contact_id": user?.id};

      final response = await _restClientBase.put(_addContactUrl, data: body);

      _logger.log(Level.debug, "adding contact response is: $response");

      if (response == null) return false;

      if (!response.containsKey("success")) return false;

      if (response['success'] == false) {
        // show error message
        return false;
      }

      return true;
    } on RestClientException {
      rethrow;
    } catch (error, stackTrace) {
      _logger.log(Level.error, "add contact error is: $error");
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
