part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final String errorMessage;

  ErrorLoginState(this.errorMessage);
}

class AuthorizedState extends LoginState {}

class UnauthorizedState extends LoginState {}
