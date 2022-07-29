import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/create_refund_order.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/save_refund_order_to_cache.dart';

part 'return_data_screen_state.dart';
part 'return_data_screen_cubit.freezed.dart';

class ReturnDataScreenCubit extends Cubit<ReturnDataScreenState> {
  final PharmacyRepository _pharmacyRepository;
  final SaveRefundOrderToCache _saveRefundOrderToCache;
  ReturnDataScreenCubit(this._pharmacyRepository, this._saveRefundOrderToCache)
      : super(const ReturnDataScreenState.initialState());

  Future<void> checkRefundOrder({
    required String incomingDate,
    required String incomingNumber,
  }) async {
    emit(const ReturnDataScreenState.loadingState());

    final result = await _pharmacyRepository.getRefundOrderByIncoming(
      incomingDate: incomingDate,
      incomingNumber: incomingNumber,
    );

    result.fold(
      (l) => emit(
        ReturnDataScreenState.errorState(message: mapFailureToMessage(l)),
      ),
      (r) async {
        emit(ReturnDataScreenState.loadedState(refundDataDTO: r.first));
      },
    );
  }
}
