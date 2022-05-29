// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductsLoacalDS {
  Future<ProductDTO> getPharmacySelectedProductFromCahce();

  Future<void> setPharmacySelectedProductToCahce({
    required ProductDTO selectedProduct,
  });
}

const PHARMACY_SELECTED_PRODUCT = 'PHARMACY_SELECTED_PRODUCT';

class ProductsLoacalDSImpl extends ProductsLoacalDS {
  final SharedPreferences sharedPreferences;

  ProductsLoacalDSImpl(this.sharedPreferences);
  @override
  Future<ProductDTO> getPharmacySelectedProductFromCahce() async {
    try {
      final product = sharedPreferences.get(PHARMACY_SELECTED_PRODUCT);
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
    sharedPreferences.setString(
      PHARMACY_SELECTED_PRODUCT,
      jsonEncode(selectedProduct.toJson()),
    );
  }
}
