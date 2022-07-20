import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class GetRefundOrderByIncoming
    extends UseCase<List<PharmacyOrderDTO>, GetRefundOrderByIncomingParams> {
  final PharmacyRepository _pharmacyRepository;

  GetRefundOrderByIncoming(this._pharmacyRepository);
  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>> call(
    GetRefundOrderByIncomingParams params,
  ) {
    return _pharmacyRepository.getRefundOrderByIncoming(
      incomingDate: params.incomingDate,
      incomingNumber: params.incomingNumber,
    );
  }
}

class GetRefundOrderByIncomingParams {
  final String? incomingDate;
  final String? incomingNumber;

  GetRefundOrderByIncomingParams({this.incomingDate, this.incomingNumber});
}
