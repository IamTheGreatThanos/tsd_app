import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/user.dart';

abstract class AuthRemoteDS {
  Future<User> signin({
    required String login,
    required String password,
  });
}

class AuthRemoteDSImpl extends AuthRemoteDS {
  final Dio dio;
  AuthRemoteDSImpl(this.dio);

  @override
  Future<User> signin({required String login, required String password}) async {
    try {
      final response = await dio.post(
        '$SERVER_/api/login',
        data: {
          'login': login,
          'password': password,
        },
      );

      final User user = User.fromJson(
        (response.data as Map<String, dynamic>)["user"] as Map<String, dynamic>,
      ).copyWith(
        accessToken:
            (response.data as Map<String, dynamic>)['access_token'] as String?,
      );
      log('signIn method in authremoteds:: ${response.statusCode}, ${response.data}, $login, $password');
      return user;
      
    } on DioError catch (e) {
      log('##### signIn api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
