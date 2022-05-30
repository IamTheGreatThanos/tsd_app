import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_pharmacy_selected_product.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/get_products_pharmacy_arrival.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/save_pharmacy_selected_product.dart';
import 'package:pharmacy_arrival/domain/usecases/pharmacy_usecases/update_pharmacy_product_by_id.dart';

part 'goods_list_screen_state.dart';
part 'goods_list_screen_cubit.freezed.dart';

class GoodsListScreenCubit extends Cubit<GoodsListScreenState> {
  List<ProductDTO> allProducts = [];
  List<ProductDTO> unscannedProducts = [];
  List<ProductDTO> scannedProdcuts = [];
  List<ProductDTO> discrepancy = [];
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
    int? scanCount,
    int? defective,
    int? surplus,
    int? underachievement,
    int? reSorting,
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
        log("SUM::::::: ${r.scanCount! + r.defective! + r.surplus! + r.underachievement! + r.reSorting!}");
        if (r.totalCount ==
            r.scanCount! +
                r.defective! +
                r.surplus! +
                r.underachievement! +
                r.reSorting!) {
          log("${r.scanCount! + r.defective! + r.surplus! + r.underachievement! + r.reSorting!}");
          await savePharmacySelectedProductToCache(
            selectedProduct: const ProductDTO(id: -1),
          );
        }
        log("Update success:::::");
        await _getPharmacyProducts(orderId);
      },
    );
  }

  Future<void> getPharmacyProducts(
    int orderId,
  ) async {
    emit(const GoodsListScreenState.loadingState());
    await _getPharmacyProducts(orderId);
  }

//получение продуктов
  Future<void> _getPharmacyProducts(int orderId) async {
    final ProductDTO selectedProduct =
        await getPharmacySelectedProductFromCache();
    final result = await _getProductsPharmacyArrival.call(orderId);
    result.fold(
        (l) => emit(
              GoodsListScreenState.errorState(message: mapFailureToMessage(l)),
            ), (r) {
      allProducts = r;
      final List<ProductDTO> scanned = [];
      final List<ProductDTO> unscanned = [];
      final List<ProductDTO> discrepancy1 = [];
      for (final ProductDTO product in r) {
        if (product.status == '1') {
          if (product.totalCount == product.scanCount) {
            scanned.add(product);
          } else {
            unscanned.add(product);
          }
        } else {
          discrepancy1.add(product);
        }
      }
      unscannedProducts = unscanned;
      scannedProdcuts = scanned;
      discrepancy = discrepancy1;
      emit(
        GoodsListScreenState.loadedState(
          selectedProduct: selectedProduct,
          scannedProducts: scannedProdcuts,
          unscannedProducts: unscannedProducts,
          discrepancy: discrepancy,
        ),
      );
    });
  }

  ////////////SCANNER PHARMACY ARRIVAL PRODUCTS
  ///Сканер бар кода
  Future<void> scannerBarCode(
    String _scannedResult,
    int orderId,
    int quantity,
  ) async {
    //проверим есть ли выбранный продукт в кэше
    final ProductDTO selectedProduct =
        await getPharmacySelectedProductFromCache();
    if (checkProductBarCode(_scannedResult) != null) {
      final ProductDTO productDTO = checkProductBarCode(_scannedResult)!;
      log("SELECTED PRODUCT ID: ${selectedProduct.id}");
      if (selectedProduct.id == -1) {
        await savePharmacySelectedProductToCache(selectedProduct: productDTO);
        updatePharmacyProductById(
          orderId: orderId,
          productId: productDTO.id,
          scanCount: productDTO.scanCount! + quantity,
        );
        log("SCANNED SUCCESSFULLY");
      } else {
        if (selectedProduct.id != productDTO.id) {
          emit(
            const GoodsListScreenState.errorState(
              message: 'Сначало отсканируйте выбранный товар до конца',
            ),
          );
          changeToLoadedState();
        } else {
          updatePharmacyProductById(
            orderId: orderId,
            productId: productDTO.id,
            scanCount: productDTO.scanCount! + quantity,
          );
          log("SCANNED SUCCESSFULLY");
        }
      }
    } else {
      emit(
        const GoodsListScreenState.errorState(
          message: 'Нет такого товара в списке',
        ),
      );
      changeToLoadedState();
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
  Future<ProductDTO> getPharmacySelectedProductFromCache() async {
    ProductDTO productDTO = const ProductDTO(id: -1);
    final result = await _getPharmacySelectedProduct.call();
    result.fold((l) {}, (r) {
      productDTO = r;
    });
    return productDTO;
  }

// чекаем баркод товара из несканированных товаров
  ProductDTO? checkProductBarCode(String barcode) {
    ProductDTO? product;
    for (final ProductDTO productDTO in unscannedProducts) {
      if (productDTO.barcode == barcode) {
        product = productDTO;
        break;
      }
    }
    return product;
  }

//изменение стэйта
  Future<void> changeToLoadedState() async {
    final ProductDTO selectedProduct =
        await getPharmacySelectedProductFromCache();
    emit(
      GoodsListScreenState.loadedState(
        scannedProducts: scannedProdcuts,
        unscannedProducts: unscannedProducts,
        selectedProduct: selectedProduct,
        discrepancy: discrepancy,
      ),
    );
  }

  void changeToLoadingState() {
    emit(
      const GoodsListScreenState.loadingState(),
    );
  }
}
