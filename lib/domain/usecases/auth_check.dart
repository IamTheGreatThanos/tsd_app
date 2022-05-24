import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/domain/repositories/auth_repository.dart';

class AuthCheck extends UseCaseOnly<User> {
  final AuthRepository _authRepository;
  AuthCheck(this._authRepository);

  @override
  Future<Either<Failure, User>> call() async {
    return _authRepository.authCheck();
  }
}
