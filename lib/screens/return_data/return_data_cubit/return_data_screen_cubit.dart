import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/create_refund_order.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/save_refund_order_to_cache.dart';

part 'return_data_screen_state.dart';
part 'return_data_screen_cubit.freezed.dart';

class ReturnDataScreenCubit extends Cubit<ReturnDataScreenState> {
  final CreateRefundOrder _createRefundOrder;
  final SaveRefundOrderToCache _saveRefundOrderToCache;
  ReturnDataScreenCubit(this._createRefundOrder, this._saveRefundOrderToCache)
      : super(const ReturnDataScreenState.initialState());

  Future<void> createRefundOrder({
    required int counteragentId,
    required int fromCounteragentId,
    required int organizationId,
  }) async {
    emit(const ReturnDataScreenState.loadingState());

    final result = await _createRefundOrder.call(
      CreateRefundOrderParams(
        counteragentId,
        fromCounteragentId,
        organizationId,
      ),
    );

    result.fold(
      (l) => emit(
        ReturnDataScreenState.errorState(message: mapFailureToMessage(l)),
      ),
      (r) async {
        await _saveRefundOrderToCache.call(r);
        emit(ReturnDataScreenState.loadedState(refundDataDTO: r));
      },
    );
  }
}
