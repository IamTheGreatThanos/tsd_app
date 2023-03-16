part of 'accept_cont_list_cubit.dart';


@freezed
class AcceptContListState with _$AcceptContListState {
 const factory AcceptContListState.initialState() = _InitialState;

  const factory AcceptContListState.loadingState() = _LoadingState;

  const factory AcceptContListState.loadedState({
    required List<ProductDTO> containers,
    required ProductDTO selectedProduct,
  }) = _LoadedState;

    const factory AcceptContListState.successScannedState({
    required String message,
  }) = _SuccessScannedState;

  const factory AcceptContListState.acceptFinishState() = _AcceptFinishState;

  const factory AcceptContListState.errorState({
    required String message,
  }) = _ErrorState;
}
