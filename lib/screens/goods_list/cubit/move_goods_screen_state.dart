part of 'move_goods_screen_cubit.dart';

@freezed
class MoveGoodsScreenState with _$MoveGoodsScreenState {
  const factory MoveGoodsScreenState.initialState() = _InitialState;

  const factory MoveGoodsScreenState.loadingState() = _LoadingState;

  const factory MoveGoodsScreenState.loadedState({
    required List<ProductDTO> scannedProducts,
    required List<ProductDTO> unscannedProducts,
    required ProductDTO selectedProduct,
  }) = _LoadedState;

  const factory MoveGoodsScreenState.successScannedState({
    required String message,
  }) = _SuccessScannedState;

  const factory MoveGoodsScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
