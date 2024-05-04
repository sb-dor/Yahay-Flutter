import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferHelper {
  late SharedPreferences sharedPrefer;

  Future<void> initSharedPrefer() async {
    sharedPrefer = await SharedPreferences.getInstance();
  }

  Future<void> setStringByKey({required String key, required String value}) async {
    await sharedPrefer.setString(key, value);
  }

  Future<void> setIntByKey({required String key, required int value}) async {
    await sharedPrefer.setInt(key, value);
  }

  Future<void> setDoubleByKey({required String key, required double value}) async {
    await sharedPrefer.setDouble(key, value);
  }

  Future<void> setBoolByKey({required String key, required bool value}) async {
    await sharedPrefer.setBool(key, value);
  }

  //
  //
  String? getStringByKey({required String key}) {
    return sharedPrefer.getString(key);
  }

  int? getIntByKey({required String key}) {
    return sharedPrefer.getInt(key);
  }

  double? getDoubleByKey({required String key}) {
    return sharedPrefer.getDouble(key);
  }

  bool? getBoolByKey({required String key}) {
    return sharedPrefer.getBool(key);
  }
}
