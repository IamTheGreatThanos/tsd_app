// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/data/model/user.dart';

part 'pharmacy_order_dto.freezed.dart';
part 'pharmacy_order_dto.g.dart';

@freezed
class PharmacyOrderDTO with _$PharmacyOrderDTO {
  const factory PharmacyOrderDTO({
    required int id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'driver_id') int? driverId,
    @JsonKey(name: 'sender_id') int? senderId,
    @JsonKey(name: 'recipient_id') int? recipientId,
    int? status,
    String? number,
    int? container,
    @JsonKey(name: 'departure_time') String? departureTime,
    @JsonKey(name: 'from_address') String? fromAddress,
    @JsonKey(name: 'from_city_name') String? fromCityName,
    @JsonKey(name: 'to_address') String? toAddress,
    @JsonKey(name: 'to_city_name') String? toCityName,
    int? amount,
   // int? entrance

    @JsonKey(name: 'incoming_number') String? incomingNumber,
    @JsonKey(name: 'incoming_date') String? incomingDate,
    String? bin,
    @JsonKey(name: 'invoice_date') String? invoiceDate,
    @JsonKey(name: 'created_at') String? createdAt,
    User? driver,
    CounteragentDTO? sender,
    CounteragentDTO? recipient,
    @JsonKey(name: 'total_status') int? totalStatus,
    @JsonKey(name: 'yandex_time') String? yandexTime,
    @JsonKey(name: 'refund_status') int? refundStatus,
    
  }) = _PharmacyOrderDTO;

  factory PharmacyOrderDTO.fromJson(Map<String, dynamic> json) => _$PharmacyOrderDTOFromJson(json);
}
