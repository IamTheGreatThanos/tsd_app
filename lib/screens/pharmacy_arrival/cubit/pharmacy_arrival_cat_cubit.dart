import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pharmacy_arrival_cat_state.dart';
part 'pharmacy_arrival_cat_cubit.freezed.dart';

class PharmacyArrivalCatCubit extends Cubit<PharmacyArrivalCatState> {
  PharmacyArrivalCatCubit()
      : super(const PharmacyArrivalCatState.newOrdersCatState());

  void changeToNewOrdersCat() {
    emit(const PharmacyArrivalCatState.newOrdersCatState());
  }

  void changeToDiscrepanyCat() {
    emit(const PharmacyArrivalCatState.discrepancyCatState());
  }
}
