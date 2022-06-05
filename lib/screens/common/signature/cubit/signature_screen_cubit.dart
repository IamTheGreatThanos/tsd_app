import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_order_status.dart';

part 'signature_screen_state.dart';
part 'signature_screen_cubit.freezed.dart';

class SignatureScreenCubit extends Cubit<SignatureScreenState> {
  final UpdatePharmacyOrderStatus _updatePharmacyOrderStatus;
  SignatureScreenCubit(this._updatePharmacyOrderStatus)
      : super(const SignatureScreenState.initialState());

  Future<void> updateOrderStatus({
    required int orderId,
    required int status,
  }) async {
    emit(const SignatureScreenState.loadingState());
    final result = await _updatePharmacyOrderStatus.call(
      UpdatePharmacyOrderStatusParams(orderId: orderId, status: status),
    );

    result.fold(
      (l) => emit(SignatureScreenState.errorState(message: mapFailureToMessage(l))),
      (r) {
        log('SUCCESS UPDATED STATUS: ${r.status}');
        emit(const SignatureScreenState.loadedState());
      },
    );
  }
}
