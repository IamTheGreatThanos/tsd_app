part of 'return_order_cat_cubit.dart';

@freezed
class ReturnOrderCatState with _$ReturnOrderCatState {
  const factory ReturnOrderCatState.activeOrdersCatState() =
      _ActiveOrdersCatState;

  const factory ReturnOrderCatState.finishedCatState() =
      _FinishedCatState;
}
