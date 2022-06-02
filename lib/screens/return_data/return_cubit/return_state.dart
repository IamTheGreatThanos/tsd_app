part of 'return_cubit.dart';

@freezed
class ReturnState with _$ReturnState {
  const factory ReturnState.initialState() = _InitialState;

  const factory ReturnState.loadingState() = _LoadingState;

  const factory ReturnState.activeState() = _ActiveState;

  const factory ReturnState.passiveState() = _PassiveState;
}
