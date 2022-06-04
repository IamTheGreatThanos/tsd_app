import 'package:dartz/dartz.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/move_data_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

abstract class MoveDataRepository {
  ///local methods
  Future<Either<Failure, MoveDataDTO>> getMoveDataFromCache();
  Future<Either<Failure, String>> saveMoveDataToCache({
    required MoveDataDTO moveDataDTO,
  });
  Future<Either<Failure, String>> deleteMoveDataFromCache();

  Future<Either<Failure, List<ProductDTO>>> getMoveProductsFromCache();
  Future<Either<Failure, String>> saveMoveProductsToCache({
    required List<ProductDTO> products,
  });
  Future<Either<Failure, String>> deleteMoveProductsFromCache();

  ///remote methods
  Future<Either<Failure, MoveDataDTO>> createMovingOrder({
    required int senderId,
    required int recipientId,
    required int organizationId,
    required int movingType,
  });

  Future<Either<Failure, List<ProductDTO>>> getProductsMoveData({
    required int moveOrderId,
  });

  Future<Either<Failure, ProductDTO>> addMoveDataProduct({
    required int moveOrderId,
    required ProductDTO addingProduct,
  });

  Future<Either<Failure, ProductDTO>> getProductByBarcode({
    required String barcode,
  });

  Future<Either<Failure, MoveDataDTO>> updateMovingOrderStatus({
    required int moveOrderId,
    required int status,
  });

  Future<Either<Failure,List<MoveDataDTO>>> getMovingHistory();
}
