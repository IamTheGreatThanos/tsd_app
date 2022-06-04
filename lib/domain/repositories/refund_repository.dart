import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';

abstract class RefundRepository {
  ///local methods
  Future<Either<Failure, RefundDataDTO>> getRefundOrderFromCache();
  Future<Either<Failure, String>> saveRefundOrderToCache({
    required RefundDataDTO refundDataDTO,
  });
  Future<Either<Failure, String>> deleteRefundOrderFromCache();

  Future<Either<Failure, List<ProductDTO>>> getRefundProductsFromCache();
  Future<Either<Failure, String>> saveRefundProductsToCache({
    required List<ProductDTO> products,
  });
  Future<Either<Failure, String>> deleteRefundProductsFromCache();

  ///remote methods
  Future<Either<Failure, RefundDataDTO>> createRefundOrder({
    required int counteragentId,
    required int fromCounteragentId,
    required int organizationId,
  });

  Future<Either<Failure, List<ProductDTO>>> getProductsRefund({
    required int refundOrderId,
  });

  Future<Either<Failure, ProductDTO>> addRefundDataProduct({
    required int refundOrderId,
    required ProductDTO addingProduct,
  });

    Future<Either<Failure, RefundDataDTO>> updateRefundOrderStatus({
    required int refundOrderId,
    required int status,
  });

  Future<Either<Failure,List<RefundDataDTO>>> getRefundHistory();
}
