import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_move_products_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/get_product_by_barcode.dart';
import 'package:pharmacy_arrival/domain/usecases/move_data_usecases/save_move_products_to_cahce.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/get_refund_products_from_cache.dart';
import 'package:pharmacy_arrival/domain/usecases/refund_usecases/save_redund_products_to_cahce.dart';

part 'move_barcode_screen_state.dart';
part 'move_barcode_screen_cubit.freezed.dart';

class MoveBarcodeScreenCubit extends Cubit<MoveBarcodeScreenState> {
  final GetProductByBarcode _getProductByBarcode;
  final GetMoveProductsFromCache _getMoveProductsFromCache;
  final SaveMoveProductsToCache _saveMoveProductsToCache;

  final GetRefundProductsFromCache _getRefundProductsFromCache;
  final SaveRefundProductsToCache _saveRefundProductsToCache;
  MoveBarcodeScreenCubit(
    this._getProductByBarcode,
    this._getMoveProductsFromCache,
    this._saveMoveProductsToCache,
    this._getRefundProductsFromCache,
    this._saveRefundProductsToCache,
  ) : super(const MoveBarcodeScreenState.initialState());

  Future<void> getProductByBarcode({
    required String barcode,
    required bool isMoveProduct,
    required int orderId,
  }) async {
    emit(const MoveBarcodeScreenState.loadingState());

    final result = await _getProductByBarcode.call(barcode);
    result.fold(
      (l) {
        emit(
          MoveBarcodeScreenState.errorState(message: mapFailureToMessage(l)),
        );
        log(mapFailureToMessage(l));
      },
      (r) async {
        if (isMoveProduct) {
          await saveMoveProductsToCache(r, orderId);
        } else {
          await saveRefundProductsToCache(r);
        }
        emit(MoveBarcodeScreenState.loadedState(scannedProduct: r));
      },
    );
  }

  Future<void> saveRefundProductsToCache(ProductDTO scannedProduct) async {
    List<ProductDTO> cahceProducts = [];
    final result = await _getRefundProductsFromCache.call();
    result.fold((l) {
      log(mapFailureToMessage(l));
    }, (r) {
      cahceProducts = r;
    });

    cahceProducts.add(scannedProduct.copyWith(isReady: true));

    final saveResult = await _saveRefundProductsToCache(cahceProducts);
    saveResult.fold((l) {
      log(mapFailureToMessage(l));
    }, (r) {
      log(r);
    });
  }

  Future<void> saveMoveProductsToCache(
    ProductDTO scannedProduct,
    int orderId,
  ) async {
    List<ProductDTO> cahceProducts = [];
    final result = await _getMoveProductsFromCache.call(
      orderId,
    );
    result.fold((l) {
      log(mapFailureToMessage(l));
    }, (r) {
      cahceProducts = r;
    });

    cahceProducts.add(scannedProduct.copyWith(isReady: true));

    final saveResult = await _saveMoveProductsToCache(
      SaveMoveProductsToCacheParams(
        products: cahceProducts,
        moveOrderId: orderId,
      ),
    );
    saveResult.fold((l) {
      log(mapFailureToMessage(l));
    }, (r) {
      log(r);
    });
  }
}
