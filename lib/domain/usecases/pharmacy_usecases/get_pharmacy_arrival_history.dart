import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class GetPharmacyArrivalHistory
    extends UseCase<List<PharmacyOrderDTO>, GetPharmacyArrivalHistoryParams> {
  final PharmacyRepository _pharmacyRepository;

  GetPharmacyArrivalHistory(this._pharmacyRepository);
  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>> call(
    GetPharmacyArrivalHistoryParams params,
  ) {
    return _pharmacyRepository.getPharmacyArrivalHistory(
      number: params.number,
      senderId: params.senderId,
      recipientId: params.recipientId,
      refundStatus: params.refundStatus,
      page:params.page,
    );
  }
}

class GetPharmacyArrivalHistoryParams {
  final String? number;
  final int? recipientId;
  final int? senderId;
  final int? refundStatus;
  final int? page;

  GetPharmacyArrivalHistoryParams({
    this.number,
    this.recipientId,
    this.senderId,
    this.refundStatus,
    this.page,
  });
}
