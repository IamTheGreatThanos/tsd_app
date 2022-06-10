import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class UpdatePharmacyOrderStatus
    extends UseCase<PharmacyOrderDTO, UpdatePharmacyOrderStatusParams> {
  final PharmacyRepository _pharmacyRepository;

  UpdatePharmacyOrderStatus(this._pharmacyRepository);

  @override
  Future<Either<Failure, PharmacyOrderDTO>> call(
    UpdatePharmacyOrderStatusParams params,
  ) {
    return _pharmacyRepository.updatePharmacyStatusOfOrder(
      orderId: params.orderId,
      status: params.status,
      incomingNumber: params.incomingNumber,
      incomingDate: params.invoiceDate,
      bin: params.bin,
      invoiceDate: params.invoiceDate,
      recipientId: params.recipientId,
    );
  }
}

class UpdatePharmacyOrderStatusParams {
  final int orderId;
  final int status;
  final String? incomingNumber;
  final String? incomingDate;
  final String? bin;
  final String? invoiceDate;
  final int? recipientId;

  UpdatePharmacyOrderStatusParams({
    this.incomingNumber,
    this.incomingDate,
    this.bin,
    this.invoiceDate,
    required this.orderId,
    required this.status,
    this.recipientId,
  });
}
