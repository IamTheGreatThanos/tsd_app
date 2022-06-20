part of 'warehouse_arrival_cat_cubit.dart';

@freezed
class WarehouseArrivalCatState with _$WarehouseArrivalCatState {
  const factory WarehouseArrivalCatState.newOrdersCatState() =
      _NewOrdersCatState;

  const factory WarehouseArrivalCatState.discrepancyCatState() =
      _DiscrepancyCatState;
}
