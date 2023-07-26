// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

@freezed
class ProductDTO with _$ProductDTO {
  const factory ProductDTO({
    required int id,
    @JsonKey(name: 'arrival_pharmacy_id') int? arrivalPharmacyId,
    @JsonKey(name: 'moving_id') int? movingId,
    String? name,
    String? image,
    String? barcode,
    int? status,
    @JsonKey(name: 'total_count') int? totalCount,
    @JsonKey(name: 'scan_count') double? scanCount,
    String? producer,
    String? series,
    @JsonKey(name: 'serial_code') String? serialCode,
    int? defective,
    int? surplus,
    int? underachievement,
    @JsonKey(name: 're_sorting') int? reSorting,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    bool? isReady,
    int? orderID,
    int? overdue,
    int? netovar,
    int? refund,
    @JsonKey(name: 'wrong_time') int? srok,
  }) = _ProductDTO;

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);

  static String encode(List<ProductDTO> list) => jsonEncode(
        list.map<Map<String, dynamic>>((ProductDTO e) => e.toJson()).toList(),
      );

  static List<ProductDTO> decode(String list) => (jsonDecode(list)
          as List<dynamic>)
      .map<ProductDTO>((e) => ProductDTO.fromJson(e as Map<String, dynamic>))
      .toList();
}
