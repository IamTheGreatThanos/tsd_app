// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    String? accessToken,
    String? name,
    String? login,
    String? password,
    String? phone,
    int? role,
    String? avatar,
    int? status,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
