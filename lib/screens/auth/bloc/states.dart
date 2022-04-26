part of 'bloc_auth.dart';

@immutable
abstract class StateBlocAuth {}

class StateAuthLoading extends StateBlocAuth {}

class StateSuccessSignIn extends StateBlocAuth {
  final String accessToken;

  StateSuccessSignIn({
    required this.accessToken,
  });
}
