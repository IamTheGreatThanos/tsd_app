import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/warehouse_repository.dart';

class GetWarehouseArrivalOrders extends UseCaseOnly<List<WarehouseOrderDTO>> {
  final WarehouseRepository _warehouseRepository;
  GetWarehouseArrivalOrders(this._warehouseRepository);
  @override
  Future<Either<Failure, List<WarehouseOrderDTO>>> call() {
    return _warehouseRepository.getWarehouseArrivalOrders();
  }
}
