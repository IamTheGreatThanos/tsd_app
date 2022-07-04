import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class GetProductsPharmacyArrival
    extends UseCase<List<ProductDTO>, GetProductsPharmacyArrivalParams> {
  final PharmacyRepository _pharmacyRepository;
  GetProductsPharmacyArrival(
    this._pharmacyRepository,
  );
  @override
  Future<Either<Failure, List<ProductDTO>>> call(
    GetProductsPharmacyArrivalParams params,
  ) {
    return _pharmacyRepository.getProductsPharmacyArrival(
      orderId: params.orderId,
      search: params.search,
    );
  }
}

class GetProductsPharmacyArrivalParams {
  final int orderId;
  final String? search;

  GetProductsPharmacyArrivalParams({required this.orderId, this.search});
}
