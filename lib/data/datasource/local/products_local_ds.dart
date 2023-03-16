// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
//TODO Локальная бд для сохранение продуктов 

abstract class ProductsLocalDS {
  Future<ProductDTO> getPharmacySelectedProductFromCahce({
    required int orderId,
  });

  Future<void> setPharmacySelectedProductToCahce({
    required ProductDTO selectedProduct,
  });

  Future<ProductDTO> getMoveSelectedProductFromCahce({
    required int orderId,
  });

  Future<void> setMoveSelectedProductToCahce({
    required ProductDTO selectedProduct,
  });
}

const PHARMACY_SELECTED_PRODUCT = 'PHARMACY_SELECTED_PRODUCT';
const MOVE_SELECTED_PRODUCT = 'MOVE_SELECTED_PRODUCT';

class ProductsLocalDSImpl extends ProductsLocalDS {
  final SharedPreferences sharedPreferences;

  ProductsLocalDSImpl(this.sharedPreferences);
  @override
  Future<ProductDTO> getPharmacySelectedProductFromCahce({
    required int orderId,
  }) async {
    try {
      final product =
          sharedPreferences.get("$orderId $PHARMACY_SELECTED_PRODUCT");
      if (product != null) {
        return ProductDTO.fromJson(
          jsonDecode(product.toString()) as Map<String, dynamic>,
        );
      } else {
        throw CacheException(message: 'В кэше нет запрашиваемые данные');
      }
    } catch (e) {
      log('getPharmacySelectedProductFromCahce:: $e');
      throw CacheException(message: 'В кэше нет запрашиваемые данные');
    }
  }

  @override
  Future<void> setPharmacySelectedProductToCahce({
    required ProductDTO selectedProduct,
  }) async {
    log(selectedProduct.orderID.toString());
    sharedPreferences.setString(
      "${selectedProduct.orderID} $PHARMACY_SELECTED_PRODUCT",
      jsonEncode(selectedProduct.toJson()),
    );
  }

  @override
  Future<ProductDTO> getMoveSelectedProductFromCahce({
    required int orderId,
  }) async {
    try {
      final product = sharedPreferences.get("$orderId $MOVE_SELECTED_PRODUCT");
      if (product != null) {
        return ProductDTO.fromJson(
          jsonDecode(product.toString()) as Map<String, dynamic>,
        );
      } else {
        throw CacheException(message: 'В кэше нет запрашиваемые данные');
      }
    } catch (e) {
      log('getMoveSelectedProductFromCahce:: $e');
      throw CacheException(message: 'В кэше нет запрашиваемые данные');
    }
  }

  @override
  Future<void> setMoveSelectedProductToCahce({
    required ProductDTO selectedProduct,
  }) async {
    log(selectedProduct.movingId.toString());
    sharedPreferences.setString(
      "${selectedProduct.movingId} $MOVE_SELECTED_PRODUCT",
      jsonEncode(selectedProduct.toJson()),
    );
  }
}
