import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/pharmacy_repository.dart';

class UpdatePharmacyProductById
    extends UseCase<ProductDTO, UpdatePharmacyProductByIdParams> {
  final PharmacyRepository _pharmacyRepository;

  UpdatePharmacyProductById(this._pharmacyRepository);
  @override
  Future<Either<Failure, ProductDTO>> call(
    UpdatePharmacyProductByIdParams params,
  ) {
    return _pharmacyRepository.updatePharmacyProductById(
      productId: params.productId,
      status: params.status,
      scanCount: params.scanCount,
      defective: params.defective,
      surplus: params.surplus,
      underachievement: params.underachievement,
      reSorting: params.reSorting,
      overdue: params.overdue,
      netovar: params.netovar,
      refund: params.refund,
      srok: params.srok,
    );
  }
}

class UpdatePharmacyProductByIdParams {
  final int productId;
  final String? status;
  final double? scanCount;
  final int? defective;
  final int? surplus;
  final int? underachievement;
  final int? reSorting;
  final int? overdue;
  final int? netovar;
  final int? refund;
  final int? srok;
  UpdatePharmacyProductByIdParams({
    required this.productId,
    this.status,
    this.scanCount,
    this.defective,
    this.surplus,
    this.underachievement,
    this.reSorting,
    this.overdue,
    this.netovar,
    this.refund,
    this.srok,
  });
}
