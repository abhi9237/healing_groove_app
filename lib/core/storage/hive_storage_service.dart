import 'package:hive_ce/hive.dart';

import 'storage_keys.dart';

class HiveStorageService {
  HiveStorageService._();

  static Box<dynamic> get _box => Hive.box(StorageKeys.appBox);

  ///
  ///  Set Data
  ///

  static Future<void> storeUserToken(String token) async {
    await _box.put(StorageKeys.userToken, token);
  }

  static Future<void> storeRememberMe(bool value) async {
    await _box.put(StorageKeys.rememberMe, value);
  }

  static Future<void> storeTokenExpiry(int value) async {
    await _box.put(StorageKeys.tokenExpiry, value);
  }

  static Future<void> storeRefreshToken(String token) async {
    await _box.put(StorageKeys.refreshToken, token);
  }

  static Future<void> storeUserId(String token) async {
    await _box.put(StorageKeys.userId, token);
  }

  static Future<void> storeEmailVerified(bool verify) async {
    await _box.put(StorageKeys.emailVerified, verify);
  }

  static Future<void> storeUserType(String type) async {
    await _box.put(StorageKeys.userType, type);
  }

  static Future<void> storeUserEmail(String type) async {
    await _box.put(StorageKeys.userEmail, type);
  }

  static Future<void> storeUserName(String type) async {
    await _box.put(StorageKeys.userName, type);
  }

  static Future<void> storeDriverDocVerified(bool type) async {
    await _box.put(StorageKeys.storeDocVerified, type);
  }

  static Future<void> storeCompleteProfile(bool type) async {
    await _box.put(StorageKeys.passCompleteProfile, type);
  }

  ///
  ///  Get Data
  ///

  static String? getUserToken() {
    return _box.get(StorageKeys.userToken) as String?;
  }

  static String? getUserId() {
    return _box.get(StorageKeys.userId) as String?;
  }

  static String? getRefreshToken() {
    return _box.get(StorageKeys.refreshToken) as String?;
  }

  static String? getUserEmail() {
    return _box.get(StorageKeys.userEmail) as String?;
  }

  static bool? getEmailVerify() {
    return _box.get(StorageKeys.emailVerified) as bool?;
  }

  static bool? getCompleteProfile() {
    return _box.get(StorageKeys.passCompleteProfile) as bool?;
  }

  static String? getUserType() {
    return _box.get(StorageKeys.userType) as String?;
  }

  static int? getTokenExpiry() {
    return _box.get(StorageKeys.tokenExpiry) as int?;
  }

  static bool? getDocVerified() {
    return _box.get(StorageKeys.storeDocVerified) as bool?;
  }

  static bool? getRememberMe() {
    return _box.get(StorageKeys.rememberMe) as bool?;
  }

  static String? getUserName() {
    return _box.get(StorageKeys.userName) as String?;
  }

  static Future<void> eraseAllData() async {
    await _box.clear();
  }
}
