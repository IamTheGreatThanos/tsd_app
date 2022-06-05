part of 'goods_list_screen_cubit.dart';

@freezed
class GoodsListScreenState with _$GoodsListScreenState {
  const factory GoodsListScreenState.initialState() = _InitialState;

  const factory GoodsListScreenState.loadingState() = _LoadingState;

  const factory GoodsListScreenState.loadedState({
    required List<ProductDTO> scannedProducts,
    required List<ProductDTO> unscannedProducts,
    required ProductDTO selectedProduct,
    required List<ProductDTO> discrepancy,
  }) = _LoadedState;

  const factory GoodsListScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
