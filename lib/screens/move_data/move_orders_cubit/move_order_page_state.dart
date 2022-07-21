part of 'move_order_page_cubit.dart';

@freezed
class MoveOrderPageState with _$MoveOrderPageState {
  const factory MoveOrderPageState.initialState() = _InitialState;

  const factory MoveOrderPageState.loadingState() = _LoadingState;

  const factory MoveOrderPageState.loadedState({
    required List<MoveDataDTO> orders,
  }) = _LoadedState;


  const factory MoveOrderPageState.errorState({
    required String message,
  }) = _ErrorState;
}
