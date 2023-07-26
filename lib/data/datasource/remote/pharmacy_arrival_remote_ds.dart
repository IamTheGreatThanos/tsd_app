import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:pharmacy_arrival/core/platform/network_helper.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';

//TODO Приход аптека ДС
abstract class PharmacyArrivalRemoteDS {
  Future<List<PharmacyOrderDTO>> getPharmacyArrivalOrders({
    required String accessToken,
    required int page,
    required int status,
    String? incomingDate,
    String? incomingNumber,
    int? refundStatus,
    String? number,
    int? senderId,
    String? departureDate,
    int? sortType,
    String? amountStart,
    String? amountEnd,
  });

  Future<List<PharmacyOrderDTO>> getPharmacyArrivalHistory({
    required String accessToken,
    String? number,
    int? senderId,
    int? recipientId,
    int? refundStatus,
    int? page,
  });

  Future<ProductDTO> updatePharmacyProductById({
    required String accessToken,
    required int productId,
    String? status,
    double? scanCount,
    int? defective,
    int? surplus,
    int? underachievement,
    int? reSorting,
    int? overdue,
    int? netovar,
    int? refund,
    int? srok,
  });

  Future<PharmacyOrderDTO> updatePharmacyStatusOfOrder({
    required String accessToken,
    required int orderId,
    int? status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
    File? signature,
    int? totalStatus,
    int? refundStatus,
  });

  Future<List<PharmacyOrderDTO>> getOrderByNumber({
    required String accessToken,
    required String number,
    required int status,
  });

  Future<List<PharmacyOrderDTO>> getRefundOrderByIncoming({
    required String accessToken,
    String? incomingNumber,
    String? incomingDate,
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
    String? incomingDate,
    String? incomingNumber,
    int? refundStatus,
    String? number,
    int? senderId,
    String? departureDate,
    int? sortType,
    String? amountStart,
    String? amountEnd,
  }) async {
    String sort = "";
    if (sortType == 0) {
      sort = 'created_at_desc';
    } else {
      sort = 'created_at_asc';
    }
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get(
        '$SERVER_/api/arrival-pharmacy?page=$page&status=$status',
        queryParameters: {
          "page": page,
          "status": status,
          if (incomingDate != null) "incoming_date": incomingDate,
          if (incomingNumber != null) "incoming_number": incomingNumber,
          if (refundStatus != null) "refund_status": refundStatus,
          if (number != null) "number": number,
          if (senderId != null) "sender_id": senderId,
          if (departureDate != null) "departure_time": departureDate,
          if (sortType != null) "sort": sort,
          if (amountStart != null) "amount_start": amountStart,
          if (amountEnd != null) "amount_end": amountEnd,
        },
      );
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
    double? scanCount,
    int? defective,
    int? surplus,
    int? underachievement,
    int? reSorting,
    int? overdue,
    int? netovar,
    int? refund,
    int? srok,
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
          if (refund != null) "refund": refund,
          if (srok != null) "wrong_time": srok,
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
    int? status,
    String? incomingNumber,
    String? incomingDate,
    String? bin,
    String? invoiceDate,
    int? recipientId,
    File? signature,
    int? totalStatus,
    int? refundStatus,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await dio.patch(
        '$SERVER_/api/arrival-pharmacy/$orderId',
        data: {
          if (status != null) 'status': status,
          if (incomingNumber != null) 'incoming_number': incomingNumber,
          if (incomingDate != null) 'incoming_date': incomingDate,
          if (bin != null) 'bin': bin,
          if (invoiceDate != null) 'invoice_date': invoiceDate,
          if (recipientId != null) 'recipient_id': recipientId,
          if (totalStatus != null) 'total_status': totalStatus,
          if (refundStatus != null) 'refund_status': refundStatus,
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
    String? number,
    int? senderId,
    int? recipientId,
    int? refundStatus,
    int? page,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get(
        '$SERVER_/api/arrival-pharmacy/history',
        queryParameters: {
          if (number != null) "number": number,
          if (senderId != null) "sender_id": senderId,
          if (recipientId != null) "recipient_id": recipientId,
          if (refundStatus != null) "refund_status": refundStatus,
          if (page != null) "page": page,
          "status": 3,
        },
      );
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

  @override
  Future<List<PharmacyOrderDTO>> getRefundOrderByIncoming({
    required String accessToken,
    String? incomingNumber,
    String? incomingDate,
  }) async {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await dio.get(
        '$SERVER_/api/arrival-pharmacy/getbyincoming',
        queryParameters: {
          if (incomingNumber != null) "incoming_number": incomingNumber,
          if (incomingDate != null) "incoming_date": incomingDate,
        },
      );
      log('##### getRefundOrderByIncoming api:: ${response.statusCode}');

      return compute<List, List<PharmacyOrderDTO>>(
        (List list) {
          return list
              .map((e) => PharmacyOrderDTO.fromJson(e as Map<String, dynamic>))
              .toList();
        },
        (response.data as Map<String, dynamic>)['data'] as List,
      );
    } on DioError catch (e) {
      log('##### getRefundOrderByIncoming api error::: ${e.response}, ${e.error}');
      throw ServerException(
        message:
            (e.response!.data as Map<String, dynamic>)['message'] as String,
      );
    }
  }
}
