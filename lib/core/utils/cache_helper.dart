import 'package:flutter/material.dart';
import 'package:one_store_delivery/core/utils/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static Future<void> cacheInit() async {
    debugPrint('init cash helper');
    sharedPreferences = await SharedPreferences.getInstance();

    // var lang = getData(key: Keys.kLang);
    // if (lang == null) {
    //   setData(key: Keys.kLang, value: 'ar');
    // }
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    } else if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return true;
    }
    return false;
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> deleteData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<void> clearCache() async {
    await sharedPreferences.clear();
  }

  static Future<void> clearUserData() async {
    await CacheHelper.deleteData(key: AppKeys.kToken);
    await CacheHelper.deleteData(key: AppKeys.kUserId);
    await CacheHelper.deleteData(key: AppKeys.kUserName);
    await CacheHelper.deleteData(key: AppKeys.kUserPhone);
    await CacheHelper.deleteData(key: AppKeys.kUserAddress);
    await CacheHelper.deleteData(key: AppKeys.kUserRegion);
    await CacheHelper.deleteData(key: AppKeys.kUserRole);
    await CacheHelper.deleteData(key: AppKeys.kUserStatus);
    await CacheHelper.deleteData(key: AppKeys.kUserLat);
    await CacheHelper.deleteData(key: AppKeys.kUserLon);
    await CacheHelper.deleteData(key: AppKeys.kUserIsVerified);
    await CacheHelper.deleteData(key: AppKeys.kUserCreatedAt);
    await CacheHelper.deleteData(key: AppKeys.kUserUpdatedAt);
  }
}
