import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';

abstract class WarehouseRepository{
  Future<Either<Failure, List<WarehouseOrderDTO>>> getWarehouseArrivalOrders();
}
