part of 'signature_screen_cubit.dart';

@freezed
class SignatureScreenState with _$SignatureScreenState {
  const factory SignatureScreenState.initialState() = _InitialState;

  const factory SignatureScreenState.loadingState() = _LoadingState;

  const factory SignatureScreenState.loadedState() = _LoadedState;

  const factory SignatureScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
