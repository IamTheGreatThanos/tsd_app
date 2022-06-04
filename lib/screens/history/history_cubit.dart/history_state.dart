part of 'history_cubit.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initialState() = _InitialState;

  const factory HistoryState.loadingState() = _LoadingState;

  const factory HistoryState.pharmacyHistoryState({
    required List<PharmacyOrderDTO> pharmacyOrders,
  }) = _PharmacyHistoryState;

    const factory HistoryState.warehouseHistoryState({
    required List<WarehouseOrderDTO> pharmacyOrders,
  }) = _WarehouseHistoryState;

    const factory HistoryState.movingHistoryState({
    required List<MoveDataDTO> pharmacyOrders,
  }) = _MoveingHistoryState;

      const factory HistoryState.refundHistoryState({
    required List<RefundDataDTO> pharmacyOrders,
  }) = _RefundHistoryState;

  const factory HistoryState.errorState({
    required String message,
  }) = _ErrorState;
}
