import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/platform/network_info.dart';
import 'package:pharmacy_arrival/data/datasource/local/auth_local_ds.dart';
import 'package:pharmacy_arrival/data/datasource/remote/auth_remote_ds.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/domain/repositories/auth_repository.dart';

//TODO Репо для прием авторизации
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

  @override
  Future<Either<Failure, List<CounteragentDTO>>> getOrganizations() async {
    if (await networkInfo.isConnected) {
      try {
        final List<CounteragentDTO> organizations =
            await remoteDS.getOrganizations();
        return Right(organizations);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, List<CounteragentDTO>>> getCountragents() async {
    if (await networkInfo.isConnected) {
      try {
        final List<CounteragentDTO> organizations =
            await remoteDS.getCountragents();
        return Right(organizations);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      await localDS.removeUserFromCache();
      log('AuthRepositoryImpl removeUser');
      return const Right("Successfully removed from cache");
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getUserFromCahce() async {
    try {
      final user = await localDS.getUserFromCache();
      log('GET USER FROM CAHCE');
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await localDS.getUserFromCache();
        final User moveDataDTO = await remoteDS.getProfile(
          accessToken: user.accessToken ?? "",
        );
        return Right(moveDataDTO);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'Нет подключение к интернету!'));
    }
  }
}
