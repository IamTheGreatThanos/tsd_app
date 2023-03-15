import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class GetOrdersBySearch
    extends UseCase<List<PharmacyOrderDTO>, GetOrdersBySearchParams> {
  final PharmacyRepository _pharmacyRepository;
  GetOrdersBySearch(this._pharmacyRepository);
  @override
  Future<Either<Failure, List<PharmacyOrderDTO>>> call(
      GetOrdersBySearchParams params,) {
    return _pharmacyRepository.getOrdersBySearch(
      number: params.number,
      status: params.status,
    );
  }
}

class GetOrdersBySearchParams {
  final int status;
  final String number;

  GetOrdersBySearchParams({required this.status, required this.number});
}
