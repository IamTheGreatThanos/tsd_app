import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class SendSignature extends UseCase<String, SendSignatureParams> {
  final PharmacyRepository _pharmacyRepository;
  SendSignature(this._pharmacyRepository);
  @override
  Future<Either<Failure, String>> call(SendSignatureParams params) {
    return _pharmacyRepository.sendSignature(
      orderId: params.orderId,
      signature: params.signature,
    );
  }
}

class SendSignatureParams {
  final int orderId;
  final File signature;

  SendSignatureParams({required this.orderId, required this.signature});
}
