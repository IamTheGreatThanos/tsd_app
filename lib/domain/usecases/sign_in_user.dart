import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/user.dart';
import 'package:pharmacy_arrival/domain/repositories/auth_repository.dart';

class SignInUser extends UseCase<User, SignInUserParams> {
  final AuthRepository _authRepository;
  SignInUser(this._authRepository);
  @override
  Future<Either<Failure, User>> call(SignInUserParams params) async {
    return _authRepository.signInUser(
      login: params.login,
      password: params.password,
    );
  }
}

class SignInUserParams  {
  final String login;
  final String password;

  const SignInUserParams({
    required this.login,
    required this.password,
  });

}
