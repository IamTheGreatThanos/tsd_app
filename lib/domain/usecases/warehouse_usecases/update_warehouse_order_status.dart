import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/core/extension/usecases/usecase.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/warehouse_repository.dart';

class UpdateWarehouseOrderStatus
    extends UseCase<WarehouseOrderDTO, UpdateWarehouseOrderStatusParams> {
  final WarehouseRepository _warehouseRepository;

  UpdateWarehouseOrderStatus(this._warehouseRepository);

  @override
  Future<Either<Failure, WarehouseOrderDTO>> call(
    UpdateWarehouseOrderStatusParams params,
  ) {
    return _warehouseRepository.updateWarehouseStatusOfOrder(
      orderId: params.orderId,
      status: params.status,
      incomingNumber: params.incomingNumber,
      incomingDate: params.invoiceDate,
      bin: params.bin,
      invoiceDate: params.invoiceDate,
      counteragentId: params.counteragentId,
    );
  }
}

class UpdateWarehouseOrderStatusParams {
  final int orderId;
  final int status;
  final String? incomingNumber;
  final String? incomingDate;
  final String? bin;
  final String? invoiceDate;
  final int? counteragentId;

  UpdateWarehouseOrderStatusParams({
    this.incomingNumber,
    this.incomingDate,
    this.bin,
    this.invoiceDate,
    required this.orderId,
    required this.status,
    this.counteragentId,
  });
}
