part of 'counteragent_cubit.dart';

@freezed
class CounteragentState with _$CounteragentState {
  const factory CounteragentState.initialState() = _InitialState;

  const factory CounteragentState.loadingState() = _LoadingState;

  const factory CounteragentState.loadedState({
    required List<CounteragentDTO> counteragents,

  }) = _LoadedState;

  const factory CounteragentState.errorState({
    required String message,
  }) = _ErrorState;
}
