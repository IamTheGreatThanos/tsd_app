import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

abstract class PharmacyArrivalRemoteDS {
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalOrders({
    required String accessToken,
    required int page,
    required int status,
  });

  Future<List<PharmacyOrderDTO>> getPharmacyArrivalHistory({
    required String accessToken,
  });

  Future<ProductDTO> updatePharmacyProductById({
    required String accessToken,
    required int productId,
    String? status,
    int? scanCount,
    int? defective,
    int? surplus,
    int? underachievement,
    int? reSorting,
    int? overdue,
    int? netovar,
  });

  Future<PharmacyOrderDTO> updatePharmacyStatusOfOrder({
    required String accessToken,
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
    File? signature,
    int? totalStatus,
  });

  Future<List<PharmacyOrderDTO>> getOrderByNumber({
    required String accessToken,
    required String number,
    required int status,
  });

  Future<String> sendSignature({
    required int orderId,
    required String accessToken,
    required File signature,
  });
}

class PharmacyArrivalRemoteDSImpl extends PharmacyArrivalRemoteDS {
  final Dio dio;

  PharmacyArrivalRemoteDSImpl(this.dio);

  @override
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalOrders({
    required String accessToken,
    required int page,
    required int status,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio
          .get('$SERVER_/api/arrival-pharmacy?page=$page&status=$status');
      log('##### getPharmacyArrivalOrders api:: ${response.statusCode}');

      return compute<List, List<PharmacyOrderDTO>>(
        (List list) {
          return list
              .map((e) => PharmacyOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getPharmacyArrivalOrders api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<ProductDTO> updatePharmacyProductById({
    required String accessToken,
    required int productId,
    String? status,
    int? scanCount,
    int? defective,
    int? surplus,
    int? underachievement,
    int? reSorting,
    int? overdue,
    int? netovar,
    
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.patch(
        '$SERVER_/api/arrival-pharmacy-product/$productId',
        data: {
          if (status != null) 'status': status,
          if (scanCount != null) 'scan_count': scanCount,
          if (defective != null) 'defective': defective,
          if (surplus != null) 'surplus': surplus,
          if (underachievement != null) 'underachievement': underachievement,
          if (reSorting != null) 're_sorting': reSorting,
          if (underachievement != null) 'overdue': overdue,
          if (reSorting != null) 'netovar': netovar,
        },
      );

      log("##### updatePharmacyProductById api:: ${response.statusCode},${response.data}");
      return ProductDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<PharmacyOrderDTO> updatePharmacyStatusOfOrder({
    required String accessToken,
    required int orderId,
    required int status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
    File? signature,
    int? totalStatus,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      // final FormData formData = FormData.fromMap({
      //   'status': status,
      //   if (incomingNumber != null) 'incoming_number': incomingNumber,
      //   if (incomingDate != null) 'incoming_date': incomingDate,
      //   if (bin != null) 'bin': bin,
      //   if (invoiceDate != null) 'invoice_date': invoiceDate,
      //   if (recipientId != null) 'recipient_id': recipientId,
      //   if (signature != null)
      //     'signature': await MultipartFile.fromFile(
      //       'data/data/com.thousand.pharmacy_arrival/files/uri_to_file/signature_2022-06-12T20_58_27_616920.jpg',
      //     ),
      // });
      // log(signature!.path);
      final response = await dio.patch(
        '$SERVER_/api/arrival-pharmacy/$orderId',
        data: {
          'status': status,
          if (incomingNumber != null) 'incoming_number': incomingNumber,
          if (incomingDate != null) 'incoming_date': incomingDate,
          if (bin != null) 'bin': bin,
          if (invoiceDate != null) 'invoice_date': invoiceDate,
          if (recipientId != null) 'recipient_id': recipientId,
          if (totalStatus != null) 'total_status': totalStatus,
        },
      );

      log("##### updatePharmacyStatusOfOrder api:: ${response.statusCode},${response.data}");
      return PharmacyOrderDTO.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalHistory({
    required String accessToken,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get('$SERVER_/api/arrival-pharmacy/history');
      log('##### getPharmacyArrivalHistory api:: ${response.statusCode}');

      return compute<List, List<PharmacyOrderDTO>>(
        (List list) {
          return list
              .map((e) => PharmacyOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getPharmacyArrivalHistory api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<List<PharmacyOrderDTO>> getOrderByNumber({
    required String accessToken,
    required String number,
    required int status,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio
          .get('$SERVER_/api/arrival-pharmacy?number=$number&status=$status');
      log('##### getOrderByNumber api:: ${response.statusCode}');

      return compute<List, List<PharmacyOrderDTO>>(
        (List list) {
          return list
              .map((e) => PharmacyOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getOrderByNumber api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }

  @override
  Future<String> sendSignature({
    required File signature,
    required String accessToken,
    required int orderId,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          signature.path,
        ),
      });
      final response = await dio.post(
        '$SERVER_/api/arrival-pharmacy/signature/$orderId',
        data: formData,
      );

      log("##### sendSignature api:: ${response.statusCode},${response.data}");
      if (response.statusCode == 200) {
        return (response.data as Map<String, dynamic>)["message"] as String;
      } else {
        throw ServerException(
          message: (response.data as Map<String, dynamic>)['message'] as String,
        );
      }
    } on DioError catch (e) {
      log('$e');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
