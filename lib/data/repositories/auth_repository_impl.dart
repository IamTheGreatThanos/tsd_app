import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/auth_remote_ds.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDS remoteDS;
  final AuthLocalDS localDS;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.localDS,
    required this.remoteDS,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, User>> signInUser({
    required String login,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final User user =
            await remoteDS.signin(password: password, login: login);
        await localDS.saveUserToCache(user: user);
        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final user = await localDS.getUserFromCache();
        return Right(user);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

    @override
  Future<Either<Failure, User>> authCheck() async {
    try {
      final user = await localDS.getUserFromCache();
      log('AuthRepositoryImpl authCheck:: ${user.accessToken}, userID:: ${user.id}');
      if (user.accessToken == null) {
        // && user.verifyStatus != 'wait') {
        return Left(CacheFailure(message: 'Пустой токен!'));
      }
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
