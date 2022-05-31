// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'counteragent_dto.freezed.dart';
part 'counteragent_dto.g.dart';

@freezed
class CounteragentDTO with _$CounteragentDTO {
  const factory CounteragentDTO({
    required int id,
    String? name,
  }) = _CounteragentDTO;

  factory CounteragentDTO.fromJson(Map<String, dynamic> json) => _$CounteragentDTOFromJson(json);

    static String encode(List<CounteragentDTO> list) => jsonEncode(
        list.map<Map<String, dynamic>>((CounteragentDTO e) => e.toJson()).toList(),
      );

  static List<CounteragentDTO> decode(String list) => (jsonDecode(list) as List<dynamic>)
      .map<CounteragentDTO>((e) => CounteragentDTO.fromJson(e as Map<String, dynamic>))
      .toList();
}
