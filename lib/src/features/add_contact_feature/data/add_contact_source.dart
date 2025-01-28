import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:yahay/src/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/src/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/src/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/src/core/models/user_model/user_model.dart';

abstract class AddContactSource {
  Future<List<UserModel>> searchContact(String value, int page);

  Future<bool> addContact(UserModel? user);
}

class AddContactSourceImpl implements AddContactSource {
  //
  AddContactSourceImpl({
    required final Logger logger,
    required final DioSettings dioSettings,
  })  : _logger = logger,
        _dioSettings = dioSettings;

  final Logger _logger;

  final DioSettings _dioSettings;

  final String _searchContactUrl = "${AppHttpRoutes.contactsPrefix}/search";

  final String _addContactUrl = "${AppHttpRoutes.contactsPrefix}/add-contact";

  @override
  Future<List<UserModel>> searchContact(String value, int page) async {
    try {
      final response = await _dioSettings.dio.get(
        _searchContactUrl,
        data: {
          "value": value.trim(),
          "page": page,
        },
      );

      _logger.log(Level.debug, "users search response: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return <UserModel>[];

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey("success")) return <UserModel>[];

      List<dynamic> usersList = json['users']['data'];

      final userList = usersList.map((e) => UserModel.fromJson(e)).toList();

      return userList;
    } catch (e) {
      _logger.log(Level.error, "getting value error is: $e");
      FirebaseCrashlytics.instance.log(e.toString());
      return <UserModel>[];
    }
  }

  @override
  Future<bool> addContact(UserModel? user) async {
    try {
      final body = {
        "contact_id": user?.id,
      };

      final response = await _dioSettings.dio.put(_addContactUrl, data: body);

      _logger.log(Level.debug, "adding contact response is: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return false;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey("success")) return false;

      if (json['success'] == false) {
        // show error message
        return false;
      }

      return true;
    } catch (e) {
      _logger.log(Level.error, "add contact error is: $e");
      FirebaseCrashlytics.instance.log(e.toString());
      return false;
    }
  }
}
