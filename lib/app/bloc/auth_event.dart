part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class InitialLoginEvent extends AuthEvent {}

class LogInEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}
