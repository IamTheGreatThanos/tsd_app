part of 'history_cubit.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initialState() = _InitialState;

  const factory HistoryState.loadingState() = _LoadingState;

  const factory HistoryState.pharmacyHistoryState({
    required List<PharmacyOrderDTO> pharmacyOrders,
  }) = _PharmacyHistoryState;

  const factory HistoryState.pharmacyHistoryBySearch({
    required List<PharmacyOrderDTO> pharmacyOrders,
  }) = _PharmacyHistoryBySearchState;

  const factory HistoryState.warehouseHistoryState({
    required List<WarehouseOrderDTO> pharmacyOrders,
  }) = _WarehouseHistoryState;
  const factory HistoryState.warehouseHistoryBySearch({
    required List<WarehouseOrderDTO> warehouseOrders,
  }) = _WarehouseHistoryBySearchState;

  const factory HistoryState.movingHistoryState({
    required List<MoveDataDTO> pharmacyOrders,
  }) = _MoveingHistoryState;
  const factory HistoryState.movingHistoryBySearch({
    required List<MoveDataDTO> pharmacyOrders,
  }) = _MovingHistoryBySearchState;

  const factory HistoryState.refundHistoryState({
    required List<PharmacyOrderDTO> pharmacyOrders,
  }) = _RefundHistoryState;
  const factory HistoryState.refundHistoryBySearch({
    required List<RefundDataDTO> pharmacyOrders,
  }) = _RefundHistoryBySearchState;

  const factory HistoryState.refundHistoryFinishedState() =
      _RefundHistoryFinishedState;

  const factory HistoryState.errorState({
    required String message,
  }) = _ErrorState;
}
