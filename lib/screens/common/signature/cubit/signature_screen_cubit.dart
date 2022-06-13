import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/send_signature.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_order_status.dart';

part 'signature_screen_state.dart';
part 'signature_screen_cubit.freezed.dart';

class SignatureScreenCubit extends Cubit<SignatureScreenState> {
  final UpdatePharmacyOrderStatus _updatePharmacyOrderStatus;
  final SendSignature _sendSignature;
  SignatureScreenCubit(this._updatePharmacyOrderStatus, this._sendSignature)
      : super(const SignatureScreenState.initialState());

  Future<void> sendSignature({
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
    required File signature,
  }) async {
    emit(const SignatureScreenState.loadingState());
    final result = await _sendSignature
        .call(SendSignatureParams(orderId: orderId, signature: signature));
    result.fold(
        (l) => emit(
              SignatureScreenState.errorState(message: mapFailureToMessage(l)),
            ), (r) async {
      log("SIGNATURE SUCCESSFULLY SENDED");
      await _updateOrderStatus(
        orderId: orderId,
        status: status,
        incomingNumber: incomingNumber,
        incomingDate: incomingDate,
        bin: bin,
        invoiceDate: invoiceDate,
        recipientId: recipientId,
      );
    });
  }

  Future<void> updateOrderStatus({
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
    File? signature,
  }) async {
    emit(const SignatureScreenState.loadingState());
    await _updateOrderStatus(
      orderId: orderId,
      status: status,
      incomingNumber: incomingNumber,
      incomingDate: incomingDate,
      bin: bin,
      invoiceDate: invoiceDate,
      recipientId: recipientId,
    );
  }

  Future<void> _updateOrderStatus({
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
  }) async {
    final result = await _updatePharmacyOrderStatus.call(
      UpdatePharmacyOrderStatusParams(
        orderId: orderId,
        status: status,
        incomingNumber: incomingNumber,
        incomingDate: incomingDate,
        bin: bin,
        invoiceDate: invoiceDate,
        recipientId: recipientId,
      ),
    );

    result.fold(
      (l) => emit(
        SignatureScreenState.errorState(message: mapFailureToMessage(l)),
      ),
      (r) {
        log('SUCCESS UPDATED STATUS: ${r.status}');
        emit(const SignatureScreenState.loadedState());
      },
    );
  }
}
