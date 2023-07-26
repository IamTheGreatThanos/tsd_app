import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_selected_product.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_products_pharmacy_arrival.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/save_pharmacy_selected_product.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_product_by_id.dart';

part 'goods_list_screen_cubit.freezed.dart';
part 'goods_list_screen_state.dart';

class GoodsListScreenCubit extends Cubit<GoodsListScreenState> {
  List<ProductDTO> allProducts = [];
  List<ProductDTO> unscannedProducts = [];
  List<ProductDTO> scannedProdcuts = [];
  final GetProductsPharmacyArrival _getProductsPharmacyArrival;
  final UpdatePharmacyProductById _updatePharmacyProductById;
  final GetPharmacySelectedProduct _getPharmacySelectedProduct;
  final SavePharmacySelectedProduct _savePharmacySelectedProduct;
  GoodsListScreenCubit(
    this._getProductsPharmacyArrival,
    this._updatePharmacyProductById,
    this._getPharmacySelectedProduct,
    this._savePharmacySelectedProduct,
  ) : super(const GoodsListScreenState.initialState());

  Future<void> updatePharmacyProductById({
    required int orderId,
    required int productId,
    String? status,
    double? scanCount,
    int? defective,
    int? surplus,
    int? underachievement,
    int? reSorting,
    int? overdue,
    int? netovar,
    int? srok,
    String? search,
    int? refund,
  }) async {
    final result = await _updatePharmacyProductById.call(
      UpdatePharmacyProductByIdParams(
        productId: productId,
        status: status,
        scanCount: scanCount,
        defective: defective,
        surplus: surplus,
        underachievement: underachievement,
        reSorting: reSorting,
        overdue: overdue,
        netovar: netovar,
        refund: refund,
        srok: srok,
      ),
    );

    result.fold(
      (l) {
        log(mapFailureToMessage(l));
        emit(
          GoodsListScreenState.errorState(message: mapFailureToMessage(l)),
        );
      },
      (r) async {
        if (r.status == 2) {
          emit(
            const GoodsListScreenState.successScannedState(
              message: 'Продукт полностью отсканирован',
            ),
          );
        }

        //  }
        log("Update success:::::");
        await _getPharmacyProducts(
          orderId: orderId,
          search: search,
        );
      },
    );
  }

  Future<void> updateRefundProductById({
    required int orderId,
    required ProductDTO product,
    String? status,
    String? search,
    int? refund,
  }) async {
    final result = await _updatePharmacyProductById.call(
      UpdatePharmacyProductByIdParams(
        productId: product.id,
        status: status,
        refund: refund,
      ),
    );

    result.fold(
      (l) {
        log(mapFailureToMessage(l));
        emit(
          GoodsListScreenState.errorState(message: mapFailureToMessage(l)),
        );
      },
      (r) async {
        log("REFUND::::::: ${r.refund}");
        if (r.totalCount == r.refund) {
          await savePharmacySelectedProductToCache(
            selectedProduct: ProductDTO(id: -1, orderID: orderId),
          );
          emit(
            const GoodsListScreenState.successScannedState(
              message: 'Продукт полностью отсканирован',
            ),
          );
        }

        log("Refund update success:::::");
        await _getPharmacyProducts(
          orderId: orderId,
          search: search,
          refundSelectedProduct: product,
        );
      },
    );
  }

  Future<void> getPharmacyProducts({
    required int orderId,
    String? search,
  }) async {
    emit(const GoodsListScreenState.loadingState());
    await _getPharmacyProducts(
      orderId: orderId,
      search: search,
    );
  }

//TODO Логика сканирование и получение товаров в определенном заказе
//получение продуктов
  Future<void> _getPharmacyProducts({
    required int orderId,
    String? search,
    ProductDTO? refundSelectedProduct,
  }) async {
    ProductDTO selectedProduct =
        await getPharmacySelectedProductFromCache(orderId: orderId);
    if (refundSelectedProduct != null) {
      selectedProduct = refundSelectedProduct;
    }
    final result = await _getProductsPharmacyArrival.call(
      GetProductsPharmacyArrivalParams(
        orderId: orderId,
        search: search,
      ),
    );
    result.fold(
        (l) => emit(
              GoodsListScreenState.errorState(message: mapFailureToMessage(l)),
            ), (r) {
      for (final ProductDTO product in r) {
        log(product.orderID.toString());
      }
      allProducts = r;
      final List<ProductDTO> scanned = [];
      final List<ProductDTO> unscanned = [];
      for (final ProductDTO product in r) {
        if (product.status == 2) {
          scanned.add(product);
        } else {
          unscanned.add(product);
        }
      }
      unscannedProducts = unscanned;
      scannedProdcuts = scanned;
      // if (search == null) {
      //   scannedProdcuts = scanned;
      // }
      emit(
        GoodsListScreenState.loadedState(
          selectedProduct: selectedProduct,
          scannedProducts: scannedProdcuts,
          unscannedProducts: unscannedProducts,
        ),
      );
    });
  }

  ////////////SCANNER PHARMACY ARRIVAL PRODUCTS
  ///Сканер бар кода. Сканировать можно 3 способами. 1)Через баркод сканнер 2)Через камеры 3)Вручную
  Future<void> scannerBarCode({
    required String scannedResult,
    int? productId,
    required int orderId,
    String? search,
    required double quantity,
    required int scanType,
    //scan type==0 is with barcode scan type ==1 is manual
  }) async {
    if (productId != null) {
      if (checkProductIdFromUnscanned(productId) != null) {
        scanBarCodeSuccess(
          productDTO: checkProductIdFromUnscanned(productId)!,
          orderId: orderId,
          quantity: quantity,
          scanType: scanType,
        );
      } else {
        emit(
          const GoodsListScreenState.errorState(
            message: 'Нет такого товара в списке',
          ),
        );
        changeToLoadedState(orderId: orderId);
        log("SCANNED FAILED");
      }
    } else {
      if (checkProductBarCodeFromUnscanned(scannedResult) != null) {
        scanBarCodeSuccess(
          productDTO: checkProductBarCodeFromUnscanned(scannedResult)!,
          orderId: orderId,
          quantity: quantity,
          scanType: scanType,
        );
      } else {
        emit(
          const GoodsListScreenState.errorState(
            message: 'Нет такого товара в списке',
          ),
        );
        changeToLoadedState(orderId: orderId);
        log("SCANNED FAILED");
      }
    }
  }

  Future<void> scanBarCodeSuccess({
    required ProductDTO productDTO,
    required int orderId,
    String? search,
    required double quantity,
    required int scanType,
  }) async {
    //проверим есть ли выбранный продукт в кэше
    final ProductDTO selectedProduct =
        await getPharmacySelectedProductFromCache(
      orderId: orderId,
    );
    log("${selectedProduct.id},  ${selectedProduct.orderID}");
    log("SELECTED PRODUCT ID: ${selectedProduct.id}");
    if (selectedProduct.id == -1) {
      await savePharmacySelectedProductToCache(selectedProduct: productDTO);
      if (scanType == 0 &&
          productDTO.totalCount! <=
              (productDTO.scanCount ?? 0) +
                  (productDTO.defective ?? 0) +
                  (productDTO.underachievement ?? 0) +
                  (productDTO.reSorting ?? 0) +
                  (productDTO.netovar ?? 0) +
                  (productDTO.overdue ?? 0)) {
        emit(
          const GoodsListScreenState.errorState(
            message: 'Продукты уже отсканированы!',
          ),
        );
        changeToLoadedState(orderId: orderId);
      } else {
        updatePharmacyProductById(
          orderId: orderId,
          search: search,
          productId: productDTO.id,
          scanCount:
              scanType == 0 ? productDTO.scanCount! + quantity : quantity,
        );
        log("SCANNED SUCCESSFULLY");
      }
    } else {
      await savePharmacySelectedProductToCache(selectedProduct: productDTO);
      if (scanType == 0 &&
          productDTO.totalCount! <=
              (productDTO.scanCount ?? 0) +
                  (productDTO.defective ?? 0) +
                  (productDTO.underachievement ?? 0) +
                  (productDTO.reSorting ?? 0) +
                  (productDTO.netovar ?? 0) +
                  (productDTO.overdue ?? 0)) {
        emit(
          const GoodsListScreenState.errorState(
            message: 'Продукты уже отсканированы!',
          ),
        );
        changeToLoadedState(orderId: orderId);
      } else {
        updatePharmacyProductById(
          orderId: orderId,
          search: search,
          productId: productDTO.id,
          scanCount:
              scanType == 0 ? productDTO.scanCount! + quantity : quantity,
        );
        log("SCANNED SUCCESSFULLY");
      }
      //}
    }
  }

//SCANNER REFUND PRODUCTS

  Future<void> refundScannerBarCode(
    String scannedResult,
    int orderId,
    String? search,
    int quantity,
    int scanType,
  ) async {
    if (checkProductBarCodeFromScanned(scannedResult) != null) {
      final ProductDTO productDTO =
          checkProductBarCodeFromScanned(scannedResult)!;
      if (productDTO.totalCount! <= (productDTO.refund ?? 0)) {
        emit(
          const GoodsListScreenState.errorState(
            message: 'Продукты уже отсканированы!',
          ),
        );
        changeToLoadedState(orderId: orderId);
      } else {
        updateRefundProductById(
          orderId: orderId,
          search: search,
          product: productDTO,
          refund: scanType == 0 ? productDTO.refund! + quantity : quantity,
        );
        log("SCANNED SUCCESSFULLY");
      }
    } else {
      emit(
        const GoodsListScreenState.errorState(
          message: 'Нет такого товара в списке',
        ),
      );
      changeToLoadedState(orderId: orderId);
      log("SCANNED FAILED");
    }
  }

// сохранение выбранного продукта в кэш
  Future<void> savePharmacySelectedProductToCache({
    required ProductDTO selectedProduct,
  }) async {
    final result = await _savePharmacySelectedProduct(selectedProduct);
    result.fold((l) {
      log("Saving to cache failed");
    }, (r) {
      log("Saving to cache success");
    });
  }

// получение выбранного продукта из кэша
  Future<ProductDTO> getPharmacySelectedProductFromCache({
    required int orderId,
  }) async {
    ProductDTO productDTO = const ProductDTO(id: -1);
    final result = await _getPharmacySelectedProduct.call(orderId);
    result.fold((l) {}, (r) {
      productDTO = r;
    });
    return productDTO;
  }

// чекаем баркод товара из несканированных товаров

  ProductDTO? checkProductIdFromUnscanned(int id) {
    ProductDTO? product;
    for (final ProductDTO productDTO in unscannedProducts) {
      if (productDTO.id == id) {
        product = productDTO;
        break;
      }
    }
    return product;
  }

  ProductDTO? checkProductBarCodeFromUnscanned(String barcode) {
    ProductDTO? product;
    for (final ProductDTO productDTO in unscannedProducts) {
      if (productDTO.barcode!.contains(barcode)) {
        product = productDTO;
        break;
      }
    }
    return product;
  }

  // чекаем баркод товара из сканированных товаров
  ProductDTO? checkProductBarCodeFromScanned(String barcode) {
    ProductDTO? product;
    for (final ProductDTO productDTO in scannedProdcuts) {
      if (productDTO.barcode!.contains(barcode)) {
        product = productDTO;
        break;
      }
    }
    return product;
  }

//изменение стэйта
  Future<void> changeToLoadedState({
    required int orderId,
  }) async {
    final ProductDTO selectedProduct =
        await getPharmacySelectedProductFromCache(
      orderId: orderId,
    );
    emit(
      GoodsListScreenState.loadedState(
        scannedProducts: scannedProdcuts,
        unscannedProducts: unscannedProducts,
        selectedProduct: selectedProduct,
      ),
    );
  }

  void changeToLoadingState() {
    emit(
      const GoodsListScreenState.loadingState(),
    );
  }
}
