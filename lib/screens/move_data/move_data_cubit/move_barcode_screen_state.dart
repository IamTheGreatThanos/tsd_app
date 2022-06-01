part of 'move_barcode_screen_cubit.dart';

@freezed
class MoveBarcodeScreenState with _$MoveBarcodeScreenState {
  const factory MoveBarcodeScreenState.initialState() = _InitialState;

  const factory MoveBarcodeScreenState.loadingState() = _LoadingState;

  const factory MoveBarcodeScreenState.loadedState({
    required ProductDTO scannedProduct,
  }) = _LoadedState;

  const factory MoveBarcodeScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
