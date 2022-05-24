part of 'sign_in_cubit.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initialState() = _InitialState;

  const factory SignInState.loadedState({
    required User user,
  }) = _LoadedState;

  const factory SignInState.loadingState() = _LoadingState;

  const factory SignInState.errorState({
    required String message,
  }) = _ErrorState;
}
