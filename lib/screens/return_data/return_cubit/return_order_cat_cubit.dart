import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'return_order_cat_state.dart';
part 'return_order_cat_cubit.freezed.dart';

class ReturnOrderCatCubit extends Cubit<ReturnOrderCatState> {
  ReturnOrderCatCubit()
      : super(
          const ReturnOrderCatState.activeOrdersCatState(),
        );

  void changeToActiveOrdersCat() {
    emit(const ReturnOrderCatState.activeOrdersCatState());
  }

  void changeToFinishedCat() {
    emit(const ReturnOrderCatState.finishedCatState());
  }
}
