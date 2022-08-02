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

  Future<Either<Failure, List<ProductDTO>>> getMoveProductsFromCache({
    required int moveOrderId,
  });
  Future<Either<Failure, String>> saveMoveProductsToCache({
    required int moveOrderId,
    required List<ProductDTO> products,
  });
  Future<Either<Failure, String>> deleteMoveProductsFromCache({
    required int moveOrderId,
  });

  ///remote methods
  Future<Either<Failure, MoveDataDTO>> createMovingOrder({
    int? senderId,
    int? recipientId,
    int? organizationId,
    int? movingType,
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
    int? status,
    int? send,
    int? accept,
    String? date,
    String? comment,
  });

  Future<Either<Failure, List<MoveDataDTO>>> getMovingHistory();

  Future<Either<Failure, List<MoveDataDTO>>> getMovingOrders({
    int? page,
    int? status,
    int? senderId,
    int? recipientId,
    int? accept,
    int? send,
    String? date,
    int? sortType,
  });

  Future<Either<Failure, ProductDTO>> updateMoveProductById({
    required ProductDTO updatingProduct,
  });

  Future<Either<Failure, ProductDTO>> getMoveSelectedProductFromCahce({
    required int orderId,
  });

  Future<Either<Failure, String>> saveMoveSelectedProductToCahce({
    required ProductDTO selectedProduct,
  });
}
