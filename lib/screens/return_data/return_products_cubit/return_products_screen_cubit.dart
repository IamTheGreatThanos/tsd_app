import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/delete_refund_order_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/delete_refund_products_from_cahce.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/get_refund_order_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/get_refund_products_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/add_refund_data_product.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/get_products_refund.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/remote_usecases/update_moving_order_status.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/save_redund_products_to_cahce.dart';

part 'return_products_screen_state.dart';
part 'return_products_screen_cubit.freezed.dart';

class ReturnProductsScreenCubit extends Cubit<ReturnProductsScreenState> {
  final GetProductsRefund _getProductsRefund;
  final GetRefundProductsFromCache _getRefundProductsFromCache;
  final GetRefundOrderFromCache _getRefundOrderFromCache;
  final AddRefundDataProduct _addRefundDataProduct;
  final DeleteRefundProductsFromCache _deleteRefundProductsFromCache;
  final SaveRefundProductsToCache _saveRefundProductsToCache;
  final UpdateRefundOrderStatus _refundOrderStatus;
  final DeleteRefundOrderFromCache _deleteRefundOrderFromCache;
  List<ProductDTO> allProducts = [];
  bool isFinishable = false;
  ReturnProductsScreenCubit(
    this._getProductsRefund,
    this._getRefundProductsFromCache,
    this._getRefundOrderFromCache,
    this._addRefundDataProduct,
    this._deleteRefundProductsFromCache,
    this._saveRefundProductsToCache,
    this._refundOrderStatus,
    this._deleteRefundOrderFromCache,
  ) : super(const ReturnProductsScreenState.initialState());

  Future<void> updateMovingOrderStatus({
    required int refundOrderId,
    required int status,
  }) async {
    emit(const ReturnProductsScreenState.loadingState());
    final result = await _refundOrderStatus.call(
      UpdateRefundOrderStatusParams(
        refundOrderId: refundOrderId,
        status: status,
      ),
    );
    result.fold((l) {
      emit(ReturnProductsScreenState.errorState(
          message: mapFailureToMessage(l),),);
    }, (r) async {
      await _deleteRefundOrderFromCache.call();
      emit(const ReturnProductsScreenState.finishedState());
    });
  }

  Future<void> getProducts() async {
    allProducts = [];
    emit(const ReturnProductsScreenState.loadingState());

    final refundDataDTO = await _getRefundOrderFromCache.call();
    refundDataDTO.fold((l) {
      log(mapFailureToMessage(l));
    }, (r) async {
      final result = await _getProductsRefund(r.id);
      result.fold(
        (l) => emit(
          ReturnProductsScreenState.errorState(message: mapFailureToMessage(l)),
        ),
        (r1) async {
          allProducts.addAll(r1);
          await _getProductsFromCache();
          emit(
            ReturnProductsScreenState.loadedState(
              refundDataDTO: r,
              products: allProducts,
              isFinishable: isFinishable,
            ),
          );
        },
      );
    });
  }

  Future<void> _getProductsFromCache() async {
    isFinishable = false;
    final result = await _getRefundProductsFromCache.call();
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

  Future<void> addRefundDataProduct({
    required int refundOrderId,
    required ProductDTO addingProduct,
  }) async {
    //  emit(const ReturnProductsScreenState.loadingState());
    final result = await _addRefundDataProduct
        .call(AddRefundDataProductParams(refundOrderId, addingProduct));

    result.fold(
        (l) => emit(
              ReturnProductsScreenState.errorState(
                message: mapFailureToMessage(l),
              ),
            ), (r) async {
      await deleteProductFromCahceById(productId: addingProduct.id);
      await getProducts();
    });
  }

  Future<void> deleteProductFromCahceById({required int productId}) async {
    List<ProductDTO> cacheProducts = [];
    final result = await _getRefundProductsFromCache();
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

    await _deleteRefundProductsFromCache.call();
    final saveResult = await _saveRefundProductsToCache(cacheProducts);
    saveResult.fold((l) {
      log(mapFailureToMessage(l));
    }, (r) {
      log(r);
    });
  }
}
