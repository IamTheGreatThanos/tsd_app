import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'move_order_cat_state.dart';
part 'move_order_cat_cubit.freezed.dart';

class MoveOrderCatCubit extends Cubit<MoveOrderCatState> {
  MoveOrderCatCubit()
      : super(
          const MoveOrderCatState.accept(),
        );

  void changeToAcceptOrdersCat() {
    emit(const MoveOrderCatState.accept());
  }

  void changeToSendCat() {
    emit(const MoveOrderCatState.send());
  }

    void changeToAlreadyAcceptedCat() {
    emit(const MoveOrderCatState.alreadyAccepted());
  }


}
