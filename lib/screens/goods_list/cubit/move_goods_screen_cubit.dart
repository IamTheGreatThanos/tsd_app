import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/domain/repositories/move_data_repository.dart';

part 'move_goods_screen_state.dart';
part 'move_goods_screen_cubit.freezed.dart';

class MoveGoodsScreenCubit extends Cubit<MoveGoodsScreenState> {
  List<ProductDTO> allProducts = [];
  List<ProductDTO> unscannedProducts = [];
  List<ProductDTO> scannedProdcuts = [];
  final MoveDataRepository _moveDataRepository;
  MoveGoodsScreenCubit(
    this._moveDataRepository,
  ) : super(const MoveGoodsScreenState.initialState());

  Future<void> updateMoveProductById({
    required int orderId,
    required ProductDTO productDTO,
    String? search,
  }) async {
    final result = await _moveDataRepository.updateMoveProductById(
      updatingProduct: productDTO,
    );

    result.fold(
      (l) {
        log(mapFailureToMessage(l));
        emit(
          MoveGoodsScreenState.errorState(message: mapFailureToMessage(l)),
        );
      },
      (r) async {
        if (r.status == 2) {
          emit(
            const MoveGoodsScreenState.successScannedState(
              message: 'Продукт полностью отсканирован',
            ),
          );
        }

        //  }
        log("Update success:::::");
        await _getMoveProducts(orderId, search);
      },
    );
  }

  Future<void> getMoveProducts({
    required int orderId,
    String? search,
  }) async {
    emit(const MoveGoodsScreenState.loadingState());
    await _getMoveProducts(orderId, search);
  }
//TODO Логика получение и сканирование товаров возврата
//получение продуктов
  Future<void> _getMoveProducts(int orderId, String? search) async {
    final ProductDTO selectedProduct =
        await getMoveSelectedProductFromCache(orderId: orderId);
    final result =
        await _moveDataRepository.getProductsMoveData(moveOrderId: orderId);
    result.fold(
        (l) => emit(
              MoveGoodsScreenState.errorState(message: mapFailureToMessage(l)),
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
        MoveGoodsScreenState.loadedState(
          selectedProduct: selectedProduct,
          scannedProducts: scannedProdcuts,
          unscannedProducts: unscannedProducts,
        ),
      );
    });
  }

  ////////////SCANNER MOVE PRODUCTS
  ///Сканер бар кода
  Future<void> scannerBarCode({
    required String scannedResult,
    required int orderId,
    String? search,
    required double quantity,
    required int scanType,
    //scan type==0 is with barcode scan type ==1 is manual
  }) async {
    //проверим есть ли выбранный продукт в кэше
    final ProductDTO selectedProduct = await getMoveSelectedProductFromCache(
      orderId: orderId,
    );
    log("${selectedProduct.id},  ${selectedProduct.orderID}");
    if (checkProductBarCode(scannedResult) != null) {
      final ProductDTO productDTO = checkProductBarCode(scannedResult)!;
      log("SELECTED PRODUCT ID: ${selectedProduct.id}");
      if (selectedProduct.id == -1) {
        await saveMoveSelectedProductToCache(selectedProduct: productDTO);
        if (scanType==0&&productDTO.totalCount! <=
            (productDTO.scanCount ?? 0) +
                (productDTO.defective ?? 0) +
                (productDTO.underachievement ?? 0) +
                (productDTO.reSorting ?? 0) +
                (productDTO.netovar ?? 0) +
                (productDTO.overdue ?? 0)) {
          emit(
            const MoveGoodsScreenState.errorState(
              message: 'Продукты уже отсканированы!',
            ),
          );
          changeToLoadedState(orderId: orderId);
        } else {
          updateMoveProductById(
            orderId: orderId,
            productDTO: ProductDTO(
              id: productDTO.id,
              scanCount:
                  scanType == 0 ? productDTO.scanCount! + quantity : quantity,
            ),
          );
          log("SCANNED SUCCESSFULLY");
        }
      } else {
        if (selectedProduct.orderID == productDTO.orderID &&
            selectedProduct.id != productDTO.id) {
          emit(
            const MoveGoodsScreenState.errorState(
              message: 'Сначала отсканируйте выбранный товар до конца',
            ),
          );
          changeToLoadedState(
            orderId: orderId,
          );
        } else {
          if (scanType==0&&productDTO.totalCount! <=
              (productDTO.scanCount ?? 0) +
                  (productDTO.defective ?? 0) +
                  (productDTO.underachievement ?? 0) +
                  (productDTO.reSorting ?? 0) +
                  (productDTO.netovar ?? 0) +
                  (productDTO.overdue ?? 0)) {
            emit(
              const MoveGoodsScreenState.errorState(
                message: 'Продукты уже отсканированы!',
              ),
            );
            changeToLoadedState(orderId: orderId);
          } else {
            updateMoveProductById(
              orderId: orderId,
              productDTO: ProductDTO(
                id: productDTO.id,
                scanCount:
                    scanType == 0 ? productDTO.scanCount! + quantity : quantity,
              ),
            );
            log("SCANNED SUCCESSFULLY");
          }
        }
      }
    } else {
      emit(
        const MoveGoodsScreenState.errorState(
          message: 'Нет такого товара в списке',
        ),
      );
      changeToLoadedState(orderId: orderId);
      log("SCANNED FAILED");
    }
  }

// сохранение выбранного продукта в кэш
  Future<void> saveMoveSelectedProductToCache({
    required ProductDTO selectedProduct,
  }) async {
    final result = await _moveDataRepository.saveMoveSelectedProductToCahce(
      selectedProduct: selectedProduct,
    );
    result.fold((l) {
      log("Saving to cache failed");
    }, (r) {
      log("Saving to cache success");
    });
  }

// получение выбранного продукта из кэша
  Future<ProductDTO> getMoveSelectedProductFromCache({
    required int orderId,
  }) async {
    ProductDTO productDTO = const ProductDTO(id: -1);
    final result = await _moveDataRepository.getMoveSelectedProductFromCahce(
      orderId: orderId,
    );
    result.fold((l) {}, (r) {
      productDTO = r;
    });
    return productDTO;
  }

// чекаем баркод товара из несканированных товаров
  ProductDTO? checkProductBarCode(String barcode) {
    ProductDTO? product;
    for (final ProductDTO productDTO in unscannedProducts) {
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
    final ProductDTO selectedProduct = await getMoveSelectedProductFromCache(
      orderId: orderId,
    );
    emit(
      MoveGoodsScreenState.loadedState(
        scannedProducts: scannedProdcuts,
        unscannedProducts: unscannedProducts,
        selectedProduct: selectedProduct,
      ),
    );
  }

  void changeToLoadingState() {
    emit(
      const MoveGoodsScreenState.loadingState(),
    );
  }
}
