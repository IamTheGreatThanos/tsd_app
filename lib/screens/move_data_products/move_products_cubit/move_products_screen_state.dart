part of 'move_products_screen_cubit.dart';

@freezed
class MoveProductsScreenState with _$MoveProductsScreenState {
  const factory MoveProductsScreenState.initialState() = _InitialState;

  const factory MoveProductsScreenState.loadingState() = _LoadingState;

  const factory MoveProductsScreenState.loadedState({
    required List<ProductDTO> products,
    required bool isFinishable,
  }) = _LoadedState;

  const factory MoveProductsScreenState.finishedState() = _FinishedState;

  const factory MoveProductsScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
