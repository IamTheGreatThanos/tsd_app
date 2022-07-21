import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/create_moving_order.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/save_move_data_to_cache.dart';

part 'move_data_screen_state.dart';
part 'move_data_screen_cubit.freezed.dart';

class MoveDataScreenCubit extends Cubit<MoveDataScreenState> {
  final CreateMovingOrder _createMovingOrder;
  final SaveMoveDataToCache _saveMoveDataToCache;
  MoveDataScreenCubit(this._createMovingOrder, this._saveMoveDataToCache)
      : super(const MoveDataScreenState.initialState());

  Future<void> createMovingOrder({
     int? senderId,
     int? recipientId,
     int? organizationId,
     int? movingType,
  }) async {
    emit(const MoveDataScreenState.loadingState());

    final result = await _createMovingOrder.call(
      CreateMovingOrderParams(
        senderId: senderId,
        recipientId: recipientId,
        organizationId: organizationId,
        movingType: movingType,
      ),
    );

    result.fold(
      (l) => emit(
        MoveDataScreenState.errorState(message: mapFailureToMessage(l)),
      ),
      (r) async{
        await _saveMoveDataToCache.call(r);
        emit(MoveDataScreenState.loadedState(moveDataDTO: r));
      },
    );
  }
}
