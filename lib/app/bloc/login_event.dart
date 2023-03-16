part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class InitialLoginEvent extends LoginEvent {}

class LogInEvent extends LoginEvent {}

class LogOutEvent extends LoginEvent {}
