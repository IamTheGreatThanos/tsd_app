part of 'return_products_screen_cubit.dart';

@freezed
class ReturnProductsScreenState with _$ReturnProductsScreenState {
  const factory ReturnProductsScreenState.initialState() = _InitialState;

  const factory ReturnProductsScreenState.loadingState() = _LoadingState;

  const factory ReturnProductsScreenState.loadedState({
    required List<ProductDTO> products,
    required RefundDataDTO refundDataDTO,
    required bool isFinishable,
  }) = _LoadedState;

  const factory ReturnProductsScreenState.finishedState() = _FinishedState;

  const factory ReturnProductsScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
