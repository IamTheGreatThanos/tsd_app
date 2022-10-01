// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'warehouse_order_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WarehouseOrderDTO _$WarehouseOrderDTOFromJson(Map<String, dynamic> json) {
  return _WarehouseOrderDTO.fromJson(json);
}

/// @nodoc
mixin _$WarehouseOrderDTO {
  int get id => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  String? get number => throw _privateConstructorUsedError;
  @JsonKey(name: 'counteragent_id')
  int? get counteragentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  int? get container => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  CounteragentDTO? get counteragent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseOrderDTOCopyWith<WarehouseOrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseOrderDTOCopyWith<$Res> {
  factory $WarehouseOrderDTOCopyWith(
          WarehouseOrderDTO value, $Res Function(WarehouseOrderDTO) then) =
      _$WarehouseOrderDTOCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int? status,
      String? number,
      @JsonKey(name: 'counteragent_id') int? counteragentId,
      @JsonKey(name: 'user_id') int? userId,
      int? container,
      @JsonKey(name: 'created_at') String? createdAt,
      CounteragentDTO? counteragent});

  $CounteragentDTOCopyWith<$Res>? get counteragent;
}

/// @nodoc
class _$WarehouseOrderDTOCopyWithImpl<$Res>
    implements $WarehouseOrderDTOCopyWith<$Res> {
  _$WarehouseOrderDTOCopyWithImpl(this._value, this._then);

  final WarehouseOrderDTO _value;
  // ignore: unused_field
  final $Res Function(WarehouseOrderDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? number = freezed,
    Object? counteragentId = freezed,
    Object? userId = freezed,
    Object? container = freezed,
    Object? createdAt = freezed,
    Object? counteragent = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      counteragentId: counteragentId == freezed
          ? _value.counteragentId
          : counteragentId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      container: container == freezed
          ? _value.container
          : container // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      counteragent: counteragent == freezed
          ? _value.counteragent
          : counteragent // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
    ));
  }

  @override
  $CounteragentDTOCopyWith<$Res>? get counteragent {
    if (_value.counteragent == null) {
      return null;
    }

    return $CounteragentDTOCopyWith<$Res>(_value.counteragent!, (value) {
      return _then(_value.copyWith(counteragent: value));
    });
  }
}

/// @nodoc
abstract class _$$_WarehouseOrderDTOCopyWith<$Res>
    implements $WarehouseOrderDTOCopyWith<$Res> {
  factory _$$_WarehouseOrderDTOCopyWith(_$_WarehouseOrderDTO value,
          $Res Function(_$_WarehouseOrderDTO) then) =
      __$$_WarehouseOrderDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int? status,
      String? number,
      @JsonKey(name: 'counteragent_id') int? counteragentId,
      @JsonKey(name: 'user_id') int? userId,
      int? container,
      @JsonKey(name: 'created_at') String? createdAt,
      CounteragentDTO? counteragent});

  @override
  $CounteragentDTOCopyWith<$Res>? get counteragent;
}

/// @nodoc
class __$$_WarehouseOrderDTOCopyWithImpl<$Res>
    extends _$WarehouseOrderDTOCopyWithImpl<$Res>
    implements _$$_WarehouseOrderDTOCopyWith<$Res> {
  __$$_WarehouseOrderDTOCopyWithImpl(
      _$_WarehouseOrderDTO _value, $Res Function(_$_WarehouseOrderDTO) _then)
      : super(_value, (v) => _then(v as _$_WarehouseOrderDTO));

  @override
  _$_WarehouseOrderDTO get _value => super._value as _$_WarehouseOrderDTO;

  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? number = freezed,
    Object? counteragentId = freezed,
    Object? userId = freezed,
    Object? container = freezed,
    Object? createdAt = freezed,
    Object? counteragent = freezed,
  }) {
    return _then(_$_WarehouseOrderDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      counteragentId: counteragentId == freezed
          ? _value.counteragentId
          : counteragentId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      container: container == freezed
          ? _value.container
          : container // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      counteragent: counteragent == freezed
          ? _value.counteragent
          : counteragent // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WarehouseOrderDTO implements _WarehouseOrderDTO {
  const _$_WarehouseOrderDTO(
      {required this.id,
      this.status,
      this.number,
      @JsonKey(name: 'counteragent_id') this.counteragentId,
      @JsonKey(name: 'user_id') this.userId,
      this.container,
      @JsonKey(name: 'created_at') this.createdAt,
      this.counteragent});

  factory _$_WarehouseOrderDTO.fromJson(Map<String, dynamic> json) =>
      _$$_WarehouseOrderDTOFromJson(json);

  @override
  final int id;
  @override
  final int? status;
  @override
  final String? number;
  @override
  @JsonKey(name: 'counteragent_id')
  final int? counteragentId;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  final int? container;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  final CounteragentDTO? counteragent;

  @override
  String toString() {
    return 'WarehouseOrderDTO(id: $id, status: $status, number: $number, counteragentId: $counteragentId, userId: $userId, container: $container, createdAt: $createdAt, counteragent: $counteragent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WarehouseOrderDTO &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality()
                .equals(other.counteragentId, counteragentId) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.container, container) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other.counteragent, counteragent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(counteragentId),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(container),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(counteragent));

  @JsonKey(ignore: true)
  @override
  _$$_WarehouseOrderDTOCopyWith<_$_WarehouseOrderDTO> get copyWith =>
      __$$_WarehouseOrderDTOCopyWithImpl<_$_WarehouseOrderDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WarehouseOrderDTOToJson(
      this,
    );
  }
}

abstract class _WarehouseOrderDTO implements WarehouseOrderDTO {
  const factory _WarehouseOrderDTO(
      {required final int id,
      final int? status,
      final String? number,
      @JsonKey(name: 'counteragent_id') final int? counteragentId,
      @JsonKey(name: 'user_id') final int? userId,
      final int? container,
      @JsonKey(name: 'created_at') final String? createdAt,
      final CounteragentDTO? counteragent}) = _$_WarehouseOrderDTO;

  factory _WarehouseOrderDTO.fromJson(Map<String, dynamic> json) =
      _$_WarehouseOrderDTO.fromJson;

  @override
  int get id;
  @override
  int? get status;
  @override
  String? get number;
  @override
  @JsonKey(name: 'counteragent_id')
  int? get counteragentId;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  int? get container;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  CounteragentDTO? get counteragent;
  @override
  @JsonKey(ignore: true)
  _$$_WarehouseOrderDTOCopyWith<_$_WarehouseOrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
