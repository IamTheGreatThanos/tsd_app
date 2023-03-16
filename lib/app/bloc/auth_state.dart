part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class LoadingLoginState extends AuthState {}

class ErrorLoginState extends AuthState {
  final String errorMessage;

  ErrorLoginState(this.errorMessage);
}

class AuthorizedState extends AuthState {}

class UnauthorizedState extends AuthState {}
