import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/warehouse_usecases/get_warehouse_arrival_orders.dart';

part 'warehouse_arrival_screen_state.dart';
part 'warehouse_arrival_screen_cubit.freezed.dart';

class WarehouseArrivalScreenCubit extends Cubit<WarehouseArrivalScreenState> {
  GetWarehouseArrivalOrders _getWarehouseArrivalOrders;
  WarehouseArrivalScreenCubit(this._getWarehouseArrivalOrders)
      : super(const WarehouseArrivalScreenState.initialState());

  Future<void> getOrders() async {
    emit(const WarehouseArrivalScreenState.loadingState());
    final result = await _getWarehouseArrivalOrders.call();
    result.fold(
      (l) => emit(
        WarehouseArrivalScreenState.errorState(
          message: mapFailureToMessage(l),
        ),
      ),
      (r) => emit(WarehouseArrivalScreenState.loadedState(orders: r)),
    );
  }
}
