import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/get_refund_order_from_cache.dart';

part 'return_state.dart';
part 'return_cubit.freezed.dart';

class ReturnCubit extends Cubit<ReturnState> {
  final GetRefundOrderFromCache _getRefundOrderFromCache;

  ReturnCubit(this._getRefundOrderFromCache)
      : super(const ReturnState.initialState());

  Future<void> checkReturnDataOrder() async {
    emit(const ReturnState.loadingState());
    final result = await _getRefundOrderFromCache.call();
    result.fold((l) {
      emit(const ReturnState.passiveState());
    }, (r) {
      emit(const ReturnState.activeState());
    });
  }
}
