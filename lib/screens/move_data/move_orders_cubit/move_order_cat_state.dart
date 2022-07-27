part of 'move_order_cat_cubit.dart';

@freezed
class MoveOrderCatState with _$MoveOrderCatState {
  const factory MoveOrderCatState.accept() = _Accept;

  const factory MoveOrderCatState.send() = _Send;
  const factory MoveOrderCatState.alreadyAccepted() = _AlreadyAccepted;
}
