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
      incomingDate: params.incomingDate,
      incomingNumber: params.incomingNumber,
      refundStatus: params.refundStatus,
      number: params.number,
      page: params.page,
      status: params.status,
      senderId: params.senderId,
      departureDate: params.departureDate,
      sortType: params.sortType,
      amountStart: params.amountStart,
      amountEnd: params.amountEnd,
    );
  }
}

class GetPharmacyArrivalOrdersParams {
  final int page;
  final int status;

  final String? incomingDate;
  final String? incomingNumber;
  final int? refundStatus;
  final String? number;
  final int? senderId;
  final String? departureDate;
  final int? sortType;
  final String? amountStart;
  final String? amountEnd;

  GetPharmacyArrivalOrdersParams({
    this.refundStatus,
    this.incomingDate,
    this.incomingNumber,
    this.number,
    this.senderId,
    this.departureDate,
    this.sortType,
    this.amountStart,
    this.amountEnd,
    required this.page,
    required this.status,
  });
}
