part of 'return_order_page_cubit.dart';

@freezed
class ReturnOrderPageState with _$ReturnOrderPageState {
  const factory ReturnOrderPageState.initialState() = _InitialState;

  const factory ReturnOrderPageState.loadingState() = _LoadingState;

  const factory ReturnOrderPageState.loadedState({
    required List<PharmacyOrderDTO> orders,
  }) = _LoadedState;

  const factory ReturnOrderPageState.byFilterState({
    required List<PharmacyOrderDTO> orders,
  }) = _ByFilterState;


  const factory ReturnOrderPageState.errorState({
    required String message,
  }) = _ErrorState;
}
