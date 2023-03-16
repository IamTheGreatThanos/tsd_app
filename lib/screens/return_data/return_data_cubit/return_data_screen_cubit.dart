import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

part 'return_data_screen_state.dart';
part 'return_data_screen_cubit.freezed.dart';

class ReturnDataScreenCubit extends Cubit<ReturnDataScreenState> {
  final PharmacyRepository _pharmacyRepository;
  ReturnDataScreenCubit(this._pharmacyRepository)
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
