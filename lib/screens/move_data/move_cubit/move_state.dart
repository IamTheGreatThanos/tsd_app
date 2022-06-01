part of 'move_cubit.dart';


@freezed
class MoveState with _$MoveState {
  const factory MoveState.initialState() = _InitialState;

  const factory MoveState.loadingState() = _LoadingState;

  const factory MoveState.activeState({
    required MoveDataDTO moveDataDTO,
    required List<ProductDTO> products,
  }) = _ActiveState;

  const factory MoveState.passiveState() = _PassiveState;
}
