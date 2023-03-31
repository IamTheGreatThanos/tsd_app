// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';

part 'warehouse_order_dto.freezed.dart';
part 'warehouse_order_dto.g.dart';

@freezed
class WarehouseOrderDTO with _$WarehouseOrderDTO {
  const factory WarehouseOrderDTO({
    required int id,
    int? status,
    String? number,
    @JsonKey(name: 'counteragent_id') int? counteragentId,
    @JsonKey(name: 'user_id') int? userId,
    int? container,
    @JsonKey(name: 'created_at') String? createdAt,
    String? provider,
    CounteragentDTO? counteragent,
  }) = _WarehouseOrderDTO;

  factory WarehouseOrderDTO.fromJson(Map<String, dynamic> json) => _$WarehouseOrderDTOFromJson(json);
}
