import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';

abstract class WarehouseRepository {
  Future<Either<Failure, List<WarehouseOrderDTO>>> getWarehouseArrivalOrders({
    required int page,
    required int status,
    String? searchText,
  });

  Future<Either<Failure, List<WarehouseOrderDTO>>> getWarehouseArrivalHistory();

    Future<Either<Failure, WarehouseOrderDTO>> updateWarehouseStatusOfOrder({
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? counteragentId,
  });

}
