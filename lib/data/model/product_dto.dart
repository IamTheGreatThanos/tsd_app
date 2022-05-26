// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

@freezed
class ProductDTO with _$ProductDTO {
  const factory ProductDTO({
    required int id,
    @JsonKey(name:'arrival_pharmacy_id') int? arrivalPharmacyId,
    String? name,
    String? image,
    String? barcode,
    String? status,
    @JsonKey(name:'total_count') int? totalCount,
    @JsonKey(name: 'scan_count') int? scanCount,
    String? producer,
    String? series,
    int? defective,
    int? surplus,
    int? underachievement,
    @JsonKey(name: 're_sorting') int? reSorting,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ProductDTO;

  factory ProductDTO.fromJson(Map<String, dynamic> json) => _$ProductDTOFromJson(json);
}
