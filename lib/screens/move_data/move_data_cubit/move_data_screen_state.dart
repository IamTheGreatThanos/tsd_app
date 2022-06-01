part of 'move_data_screen_cubit.dart';

@freezed
class MoveDataScreenState with _$MoveDataScreenState {
  const factory MoveDataScreenState.initialState() = _InitialState;

  const factory MoveDataScreenState.loadingState() = _LoadingState;

  const factory MoveDataScreenState.loadedState({
    required MoveDataDTO moveDataDTO,
  }) = _LoadedState;

  const factory MoveDataScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
