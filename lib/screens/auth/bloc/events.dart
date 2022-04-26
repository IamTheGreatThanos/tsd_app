part of 'bloc_auth.dart';

@immutable
abstract class EventBlocAuth {}

class EventAuthInitial extends EventBlocAuth {}

class EventSignIn extends EventBlocAuth {
  final String login;
  final String password;

  EventSignIn({
    required this.login,
    required this.password,
  });
}
