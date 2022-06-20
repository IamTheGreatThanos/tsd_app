import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_arrival_cat_state.dart';
part 'warehouse_arrival_cat_cubit.freezed.dart';

class WarehouseArrivalCatCubit extends Cubit<WarehouseArrivalCatState> {
  WarehouseArrivalCatCubit()
      : super(const WarehouseArrivalCatState.newOrdersCatState());

  void changeToNewOrdersCat() {
    emit(const WarehouseArrivalCatState.newOrdersCatState());
  }

  void changeToDiscrepanyCat() {
    emit(const WarehouseArrivalCatState.discrepancyCatState());
  }
}
