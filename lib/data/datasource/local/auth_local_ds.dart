// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDS {
  Future<void> saveUserToCache({
    required User user,
  });

  Future<User> getUserFromCache();

  Future<User?> getUserFromCacheNull();

  Future<void> removeUserFromCache();
}

const USER_FROM_CACHE = 'USER';
const IS_ONBOARDING = 'IS_ONBOARDING';
const DEVICE_TOKEN = 'DEVICE_TOKEN';

class AuthLocalDSImpl extends AuthLocalDS {
  final SharedPreferences sharedPreferences;

  AuthLocalDSImpl({required this.sharedPreferences});

  @override
  Future<User> getUserFromCache() async {
    try {
      final user = sharedPreferences.get(USER_FROM_CACHE);
      if (user != null) {
        return User.fromJson(
          jsonDecode(user.toString()) as Map<String, dynamic>,
        );
      } else {
        throw CacheException(message: 'В кэше нет запрашиваемые данные');
      }
    } catch (e) {
      log('AuthLocalDSImpl:: $e');
      throw CacheException(message: 'В кэше нет запрашиваемые данные');
    }
  }

  @override
  Future<User?> getUserFromCacheNull() async {
    try {
      final user = sharedPreferences.get(USER_FROM_CACHE);
      if (user != null) {
        return User.fromJson(
          jsonDecode(user.toString()) as Map<String, dynamic>,
        );
      }
      return null;
    } catch (e) {
      log('AuthLocalDSImpl getUserFromCacheNull:: $e');
      throw CacheException(message: 'В кэше нет запрашиваемые данные');
    }
  }

  @override
  Future<void> saveUserToCache({required User user}) async {
    sharedPreferences.setString(USER_FROM_CACHE, jsonEncode(user.toJson()));
  }

  @override
  Future<void> removeUserFromCache() async {
    sharedPreferences.remove(USER_FROM_CACHE);
  }
}
