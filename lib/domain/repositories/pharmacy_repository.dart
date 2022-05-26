import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

abstract class PharmacyRepository{
  Future<Either<Failure, List<PharmacyOrderDTO>>> getPharmacyArrivalOrders();

  Future<Either<Failure, List<ProductDTO>>> getProductsPharmacyArrival({
    required int orderId,
  });
}