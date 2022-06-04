part of 'history_cat_cubit.dart';

@freezed
class HistoryCatState with _$HistoryCatState {
  const factory HistoryCatState.pharmacyHistoryCatState() = _PharmacyHistoryCatState;

  const factory HistoryCatState.warehouseHistoryCatState() =
      _WarehouseHistoryCatState;

  const factory HistoryCatState.movingHistoryCatState() = _MoveingHistoryCatState;

  const factory HistoryCatState.refundHistoryCatState() = _RefundHistoryCatState;
}
