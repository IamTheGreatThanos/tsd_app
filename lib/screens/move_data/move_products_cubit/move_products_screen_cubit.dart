import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/add_move_data_product.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/delete_move_data_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/delete_move_products_from_cahce.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_data_products.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_products_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/save_move_products_to_cahce.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/update_moving_order_status.dart';

part 'move_products_screen_state.dart';
part 'move_products_screen_cubit.freezed.dart';

class MoveProductsScreenCubit extends Cubit<MoveProductsScreenState> {
  final GetMoveDataProducts _getMoveDataProducts;
  final GetMoveProductsFromCache _getMoveProductsFromCache;
  final DeleteMoveProductsFromCache _deleteMoveProductsFromCache;
  final SaveMoveProductsToCache _saveMoveProductsToCache;
  final AddMoveDataProduct _addMoveDataProduct;
  final UpdateMovingOrderStatus _movingOrderStatus;
  final DeleteMoveDataFromCache _deleteMoveDataFromCache;

  final MoveDataRepository _moveDataRepository;
  List<ProductDTO> allProducts = [];
  bool isFinishable = false;
  MoveProductsScreenCubit(
    this._getMoveDataProducts,
    this._getMoveProductsFromCache,
    this._addMoveDataProduct,
    this._deleteMoveProductsFromCache,
    this._saveMoveProductsToCache,
    this._movingOrderStatus,
    this._deleteMoveDataFromCache,
    this._moveDataRepository,
  ) : super(const MoveProductsScreenState.initialState());

  Future<void> updateMovingOrderStatus({
    required int moveOrderId,
    int? status,
    int? send,
    int? accept,
    String? date,
    String? comment,
  }) async {
    emit(const MoveProductsScreenState.loadingState());
    final result = await _movingOrderStatus.call(
      UpdateMovingOrderStatusParams(
        moveOrderId: moveOrderId,
        status: status,
        send: send,
        accept: accept,
        date: date,
        comment: comment,
      ),
    );
    result.fold((l) {
      emit(MoveProductsScreenState.errorState(message: mapFailureToMessage(l)));
    }, (r) async {
      await _deleteMoveDataFromCache.call();
      emit(const MoveProductsScreenState.finishedState());
    });
  }

  Future<void> getProducts({
    required int moveOrderId,
  }) async {
    allProducts = [];
    emit(const MoveProductsScreenState.loadingState());
    final result = await _getMoveDataProducts(moveOrderId);
    result.fold(
      (l) => emit(
        MoveProductsScreenState.errorState(message: mapFailureToMessage(l)),
      ),
      (r) async {
        allProducts.addAll(r);
        await _getProductsFromCache(
          moveOrderId: moveOrderId,
        );
        emit(
          MoveProductsScreenState.loadedState(
            products: allProducts,
            isFinishable: isFinishable,
          ),
        );
      },
    );
  }

  Future<void> _getProductsFromCache({
    required int moveOrderId,
  }) async {
    isFinishable = false;
    //   const ProductDTO productDTO = ProductDTO(
    //     id: 11,
    //     name: "Акнекутан капс. 16мг №30",
    //     barcode: "110115",
    //     producer: "Jadran",
    //     totalCount: 86,
    //     isReady: true,
    //   );
    //  const ProductDTO productDTO2 = ProductDTO(
    //     id: 8,
    //     name: "Оптинол Глубокое увлажнение 0,4% 10мл",
    //     barcode: "96542",
    //     producer: "Jadran",
    //     totalCount: 45,
    //     isReady: true,
    //   );
    //      const ProductDTO productDTO3 = ProductDTO(
    //     id: 91,
    //     name: "Example5",
    //     barcode: "18858",
    //     producer: "Europharma",
    //     totalCount: 96,
    //     isReady: true,
    //   );
    //    final saveResult = await _saveMoveProductsToCache([productDTO,productDTO2]);
    final result = await _getMoveProductsFromCache.call(
      moveOrderId,
    );
    result.fold(
      (l) {
        isFinishable = true;
        log("GetProductsFromCache Failed");
      },
      (r) {
        if (r.isEmpty) {
          isFinishable = true;
        }
        allProducts.addAll(r);
      },
    );
  }

  Future<void> updateMoveDataProduct({
    required int moveOrderId,
    required ProductDTO updatingProduct,
  }) async {
    emit(const MoveProductsScreenState.loadingState());
    final result = await _moveDataRepository.updateMoveProductById(
        updatingProduct: updatingProduct,);

    result.fold(
        (l) => emit(
              MoveProductsScreenState.errorState(
                message: mapFailureToMessage(l),
              ),
            ), (r) async {
      await getProducts(moveOrderId: moveOrderId);
    });
  }

  Future<void> addMoveDataProduct({
    required int moveOrderId,
    required ProductDTO addingProduct,
  }) async {
    emit(const MoveProductsScreenState.loadingState());
    final result = await _addMoveDataProduct
        .call(AddMoveDataProductParams(moveOrderId, addingProduct));

    result.fold(
        (l) => emit(
              MoveProductsScreenState.errorState(
                message: mapFailureToMessage(l),
              ),
            ), (r) async {
      await deleteProductFromCahceById(
        productId: addingProduct.id,
        moveOrderId: moveOrderId,
      );
      await getProducts(moveOrderId: moveOrderId);
    });
  }

  Future<void> deleteProductFromCahceById({
    required int productId,
    required int moveOrderId,
  }) async {
    List<ProductDTO> cacheProducts = [];
    final result = await _getMoveProductsFromCache(moveOrderId);
    result.fold((l) {
      log('GetProductsFromCache not success');
    }, (r) {
      cacheProducts = r;
    });

    for (int i = 0; i < cacheProducts.length; i++) {
      if (cacheProducts[i].id == productId) {
        cacheProducts.removeAt(i);
        break;
      }
    }

    await _deleteMoveProductsFromCache.call(
      moveOrderId,
    );
    final saveResult = await _saveMoveProductsToCache(
      SaveMoveProductsToCacheParams(
        moveOrderId: moveOrderId,
        products: cacheProducts,
      ),
    );
    saveResult.fold((l) {
      log(mapFailureToMessage(l));
    }, (r) {
      log(r);
    });
  }
}
