// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductDTO _$$_ProductDTOFromJson(Map<String, dynamic> json) =>
    _$_ProductDTO(
      id: json['id'] as int,
      arrivalPharmacyId: json['arrival_pharmacy_id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      barcode: json['barcode'] as String?,
      status: json['status'] as String?,
      totalCount: json['total_count'] as int?,
      scanCount: json['scan_count'] as int?,
      producer: json['producer'] as String?,
      series: json['series'] as String?,
      defective: json['defective'] as int?,
      surplus: json['surplus'] as int?,
      underachievement: json['underachievement'] as int?,
      reSorting: json['re_sorting'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$_ProductDTOToJson(_$_ProductDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'arrival_pharmacy_id': instance.arrivalPharmacyId,
      'name': instance.name,
      'image': instance.image,
      'barcode': instance.barcode,
      'status': instance.status,
      'total_count': instance.totalCount,
      'scan_count': instance.scanCount,
      'producer': instance.producer,
      'series': instance.series,
      'defective': instance.defective,
      'surplus': instance.surplus,
      'underachievement': instance.underachievement,
      're_sorting': instance.reSorting,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };