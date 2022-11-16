import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/warehouse_repository.dart';

class GetWarehouseArrivalOrders extends UseCase<List<WarehouseOrderDTO>, GetWarehouseArrivalOrdersParams> {
  final WarehouseRepository _warehouseRepository;
  GetWarehouseArrivalOrders(this._warehouseRepository);
  @override
  Future<Either<Failure, List<WarehouseOrderDTO>>> call(
    GetWarehouseArrivalOrdersParams params,
  ) {
    return _warehouseRepository.getWarehouseArrivalOrders(
      page: params.page,
      status: params.status,
      searchText: params.searchText,
    );
  }
}

class GetWarehouseArrivalOrdersParams {
  final int page;
  final int status;
  final String? searchText;

  GetWarehouseArrivalOrdersParams({
    required this.page,
    required this.status,
    this.searchText,
  });
}
