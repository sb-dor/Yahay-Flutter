import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:yahay/core/app_settings/dio/app_http_routes.dart';
import 'package:yahay/core/app_settings/dio/dio_settings.dart';
import 'package:yahay/core/app_settings/dio/http_status_codes.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/user_model/user_model.dart';
import 'package:yahay/features/add_contact_feature/data/sources/add_contact_source/add_contact_source.dart';
import 'package:yahay/injections/injections.dart';

class AddContactSourceImpl implements AddContactSource {
  final DioSettings _dioSettings = snoopy<DioSettings>();

  final String _searchContactUrl = "${AppHttpRoutes.contactsPrefix}/search";
  final String _addContactUrl = "${AppHttpRoutes.contactsPrefix}/add-contact";

  @override
  Future<List<UserModel>?> searchContact(String value, int page) async {
    try {
      final response = await _dioSettings.dio.get(
        _searchContactUrl,
        data: {
          "value": value.trim(),
          "page": page,
        },
      );

      debugPrint("users search response: ${response.data}");

      if (response.statusCode != HttpStatusCodes.success) return null;

      Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (!json.containsKey("success")) return null;

      List<dynamic> usersList = json['users']['data'];

      return usersList.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("getting value error is: $e");
      FirebaseCrashlytics.instance.log(e.toString());
      return null;
    }
  }

  @override
  Future<bool> addContact(User? user) async {
    try {
      return true;
    } catch (e) {
      FirebaseCrashlytics.instance.log(e.toString());
      return false;
    }
  }
}
