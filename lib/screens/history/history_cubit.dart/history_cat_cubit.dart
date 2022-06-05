
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_cat_state.dart';
part 'history_cat_cubit.freezed.dart';

class HistoryCatCubit extends Cubit<HistoryCatState> {
  HistoryCatCubit() : super(const HistoryCatState.pharmacyHistoryCatState());

  void changeToPharmacyCat() {
    emit(const HistoryCatState.pharmacyHistoryCatState());
  }

  void changeToWarehouseCat() {
    emit(const HistoryCatState.warehouseHistoryCatState());
  }

  void changeToMovingCat() {
    emit(const HistoryCatState.movingHistoryCatState());
  }

  void changeToRefundyCat() {
    emit(const HistoryCatState.refundHistoryCatState());
  }
}
