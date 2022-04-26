part of '../bloc_auth.dart';

extension Login on BlocAuth {
  Future<void> _signIn(EventSignIn event, Emitter<StateBlocAuth> emit) async {
    try {
      emit(StateAuthLoading());
      await Future.delayed(Duration(seconds: 3))
          .then((value) => emit(StateSuccessSignIn(accessToken: "dwad")));
    } catch (e) {}
  }
}
