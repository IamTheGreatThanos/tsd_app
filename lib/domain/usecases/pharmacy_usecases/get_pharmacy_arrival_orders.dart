import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class GetPharmacyArrivalOrders
    extends UseCase<List<PharmacyOrderDTO>, GetPharmacyArrivalOrdersParams> {
  final PharmacyRepository _pharmacyRepository;
  GetPharmacyArrivalOrders(this._pharmacyRepository);
  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>> call(
    GetPharmacyArrivalOrdersParams params,
  ) {
    return _pharmacyRepository.getPharmacyArrivalOrders(
      page: params.page,
      status: params.status,
    );
  }
}

class GetPharmacyArrivalOrdersParams {
  final int page;
  final int status;

  GetPharmacyArrivalOrdersParams(this.page, this.status);
}
