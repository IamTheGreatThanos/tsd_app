// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as int,
      accessToken: json['accessToken'] as String?,
      name: json['name'] as String?,
      login: json['login'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as int?,
      avatar: json['avatar'] as String?,
      status: json['status'] as int?,
      warehouseName: json['warehouse_name'] as String?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'accessToken': instance.accessToken,
      'name': instance.name,
      'login': instance.login,
      'password': instance.password,
      'phone': instance.phone,
      'role': instance.role,
      'avatar': instance.avatar,
      'status': instance.status,
      'warehouse_name': instance.warehouseName,
    };
