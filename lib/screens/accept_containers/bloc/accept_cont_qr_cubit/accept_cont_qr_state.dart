part of 'accept_cont_qr_cubit.dart';


@freezed
class AcceptContQrState with _$AcceptContQrState {
  const factory AcceptContQrState.initialState() = _InitialState;

  const factory AcceptContQrState.loadingState() = _LoadingState;

  const factory AcceptContQrState.loadedState({
    required List<ProductDTO> containers,
  }) = _LoadedState;

  const factory AcceptContQrState.errorState({
    required String message,
  }) = _ErrorState;
}
