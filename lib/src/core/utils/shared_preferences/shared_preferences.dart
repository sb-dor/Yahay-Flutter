import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferHelper {
  late SharedPreferences _sharedPrefer;

  Future<void> initSharedPrefer() async {
    _sharedPrefer = await SharedPreferences.getInstance();
  }

  Future<void> setStringByKey({required String key, required String value}) async {
    await _sharedPrefer.setString(key, value);
  }

  Future<void> setIntByKey({required String key, required int value}) async {
    await _sharedPrefer.setInt(key, value);
  }

  Future<void> setDoubleByKey({required String key, required double value}) async {
    await _sharedPrefer.setDouble(key, value);
  }

  Future<void> setBoolByKey({required String key, required bool value}) async {
    await _sharedPrefer.setBool(key, value);
  }

  //
  //
  String? getStringByKey({required String key}) {
    return _sharedPrefer.getString(key);
  }

  int? getIntByKey({required String key}) {
    return _sharedPrefer.getInt(key);
  }

  double? getDoubleByKey({required String key}) {
    return _sharedPrefer.getDouble(key);
  }

  bool? getBoolByKey({required String key}) {
    return _sharedPrefer.getBool(key);
  }
}
