import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> authCheck();

  Future<Either<Failure, User>> signInUser({
    required String login,
    required String password,
  });
}
