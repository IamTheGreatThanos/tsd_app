part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class InitialLoginEvent extends LoginEvent {}

class LogInEvent extends LoginEvent {
  final String accessToken;

  LogInEvent(
    this.accessToken,
  );
}

class LogOutEvent extends LoginEvent {}
