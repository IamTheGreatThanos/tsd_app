// ignore_for_file: constant_identifier_names, void_checks

import 'dart:convert';
import 'dart:developer';

import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/model/refund_data_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
//TODO Локальная бд для сохранение возращенные товары
abstract class RefundLocalDS {
  Future<RefundDataDTO> getRefundOrderFromCache();

  Future<void> saveRefundOrderToCache({
    required RefundDataDTO refundDataDTO,
  });

  Future<void> deleteRefundOrderFromCache();

    Future<List<ProductDTO>> getRefundProductsFromCache();
  Future<void> saveRefundProductsToCache({required List<ProductDTO> products});
  Future<void> deleteRefundProductsFromCache();

}

const REFUND_DATA_CACHE = 'REFUND_DATA';
const REFUND_PRODUCTS_CACHE = 'REFUND_PRODUCTS_CACHE';

class RefundLocalDSImpl extends RefundLocalDS {
  final SharedPreferences sharedPreferences;

  RefundLocalDSImpl(this.sharedPreferences);

  @override
  Future<void> deleteRefundOrderFromCache() async {
    sharedPreferences.remove(
      REFUND_DATA_CACHE,
    );
  }

  @override
  Future<RefundDataDTO> getRefundOrderFromCache() async {
    try {
      final user = sharedPreferences.get(REFUND_DATA_CACHE);
      if (user != null) {
        return RefundDataDTO.fromJson(
          jsonDecode(user.toString()) as Map<String, dynamic>,
        );
      } else {
        throw CacheException(message: 'В кэше нет запрашиваемые данные');
      }
    } catch (e) {
      log('getRefundDataFromCache:: $e');
      throw CacheException(message: 'В кэше нет запрашиваемые данные');
    }
  }

  @override
  Future<void> saveRefundOrderToCache({
    required RefundDataDTO refundDataDTO,
  }) async {
    sharedPreferences.setString(
      REFUND_DATA_CACHE,
      jsonEncode(refundDataDTO.toJson()),
    );
  }
  
  @override
  Future<void> deleteRefundProductsFromCache() async {
    log('Products removed from Cache');
    sharedPreferences.remove(
      REFUND_PRODUCTS_CACHE,
    );
  }
  
  @override
  Future<List<ProductDTO>> getRefundProductsFromCache() async {
    final jsonPersonsList =
        sharedPreferences.getStringList(REFUND_PRODUCTS_CACHE);
    if (jsonPersonsList!=null&&jsonPersonsList.isNotEmpty) {
      log('Get Products from Cache: ${jsonPersonsList.length}');
      return Future.value(
        jsonPersonsList
            .map(
              (city) =>
                  ProductDTO.fromJson(jsonDecode(city) as Map<String, dynamic>),
            )
            .toList(),
      );
    } else {
      throw CacheException(message: 'В кэше нет запрашиваемые данные');
    }
  }
  
  @override
  Future<void> saveRefundProductsToCache({required List<ProductDTO> products}) async {
    final List<String> jsonCitiesList =
        products.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(REFUND_PRODUCTS_CACHE, jsonCitiesList);
    log('Products to write Cache: ${jsonCitiesList.length}');
    return Future.value(jsonCitiesList);
  }
}
