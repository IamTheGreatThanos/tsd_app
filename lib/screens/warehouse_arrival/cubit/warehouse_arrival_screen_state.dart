part of 'warehouse_arrival_screen_cubit.dart';

@freezed
class WarehouseArrivalScreenState with _$WarehouseArrivalScreenState {
  const factory WarehouseArrivalScreenState.initialState() = _InitialState;

  const factory WarehouseArrivalScreenState.loadingState() = _LoadingState;

  const factory WarehouseArrivalScreenState.loadedState({
    required List<WarehouseOrderDTO> orders,
  }) = _LoadedState;

      const factory WarehouseArrivalScreenState.bySearch({
    required List<WarehouseOrderDTO> orders,
  }) = _BySearchState;


  const factory WarehouseArrivalScreenState.errorState({
    required String message,
  }) = _ErrorState;
}
