// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductDTO _$ProductDTOFromJson(Map<String, dynamic> json) {
  return _ProductDTO.fromJson(json);
}

/// @nodoc
mixin _$ProductDTO {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'arrival_pharmacy_id')
  int? get arrivalPharmacyId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_count')
  int? get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'scan_count')
  int? get scanCount => throw _privateConstructorUsedError;
  String? get producer => throw _privateConstructorUsedError;
  String? get series => throw _privateConstructorUsedError;
  int? get defective => throw _privateConstructorUsedError;
  int? get surplus => throw _privateConstructorUsedError;
  int? get underachievement => throw _privateConstructorUsedError;
  @JsonKey(name: 're_sorting')
  int? get reSorting => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductDTOCopyWith<ProductDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDTOCopyWith<$Res> {
  factory $ProductDTOCopyWith(
          ProductDTO value, $Res Function(ProductDTO) then) =
      _$ProductDTOCopyWithImpl<$Res>;
  $Res call(
      {int id,
      @JsonKey(name: 'arrival_pharmacy_id') int? arrivalPharmacyId,
      String? name,
      String? image,
      String? barcode,
      String? status,
      @JsonKey(name: 'total_count') int? totalCount,
      @JsonKey(name: 'scan_count') int? scanCount,
      String? producer,
      String? series,
      int? defective,
      int? surplus,
      int? underachievement,
      @JsonKey(name: 're_sorting') int? reSorting,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$ProductDTOCopyWithImpl<$Res> implements $ProductDTOCopyWith<$Res> {
  _$ProductDTOCopyWithImpl(this._value, this._then);

  final ProductDTO _value;
  // ignore: unused_field
  final $Res Function(ProductDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? arrivalPharmacyId = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? barcode = freezed,
    Object? status = freezed,
    Object? totalCount = freezed,
    Object? scanCount = freezed,
    Object? producer = freezed,
    Object? series = freezed,
    Object? defective = freezed,
    Object? surplus = freezed,
    Object? underachievement = freezed,
    Object? reSorting = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      arrivalPharmacyId: arrivalPharmacyId == freezed
          ? _value.arrivalPharmacyId
          : arrivalPharmacyId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: barcode == freezed
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
      scanCount: scanCount == freezed
          ? _value.scanCount
          : scanCount // ignore: cast_nullable_to_non_nullable
              as int?,
      producer: producer == freezed
          ? _value.producer
          : producer // ignore: cast_nullable_to_non_nullable
              as String?,
      series: series == freezed
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      defective: defective == freezed
          ? _value.defective
          : defective // ignore: cast_nullable_to_non_nullable
              as int?,
      surplus: surplus == freezed
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as int?,
      underachievement: underachievement == freezed
          ? _value.underachievement
          : underachievement // ignore: cast_nullable_to_non_nullable
              as int?,
      reSorting: reSorting == freezed
          ? _value.reSorting
          : reSorting // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProductDTOCopyWith<$Res>
    implements $ProductDTOCopyWith<$Res> {
  factory _$$_ProductDTOCopyWith(
          _$_ProductDTO value, $Res Function(_$_ProductDTO) then) =
      __$$_ProductDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      @JsonKey(name: 'arrival_pharmacy_id') int? arrivalPharmacyId,
      String? name,
      String? image,
      String? barcode,
      String? status,
      @JsonKey(name: 'total_count') int? totalCount,
      @JsonKey(name: 'scan_count') int? scanCount,
      String? producer,
      String? series,
      int? defective,
      int? surplus,
      int? underachievement,
      @JsonKey(name: 're_sorting') int? reSorting,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$_ProductDTOCopyWithImpl<$Res> extends _$ProductDTOCopyWithImpl<$Res>
    implements _$$_ProductDTOCopyWith<$Res> {
  __$$_ProductDTOCopyWithImpl(
      _$_ProductDTO _value, $Res Function(_$_ProductDTO) _then)
      : super(_value, (v) => _then(v as _$_ProductDTO));

  @override
  _$_ProductDTO get _value => super._value as _$_ProductDTO;

  @override
  $Res call({
    Object? id = freezed,
    Object? arrivalPharmacyId = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? barcode = freezed,
    Object? status = freezed,
    Object? totalCount = freezed,
    Object? scanCount = freezed,
    Object? producer = freezed,
    Object? series = freezed,
    Object? defective = freezed,
    Object? surplus = freezed,
    Object? underachievement = freezed,
    Object? reSorting = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_ProductDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      arrivalPharmacyId: arrivalPharmacyId == freezed
          ? _value.arrivalPharmacyId
          : arrivalPharmacyId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: barcode == freezed
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
      scanCount: scanCount == freezed
          ? _value.scanCount
          : scanCount // ignore: cast_nullable_to_non_nullable
              as int?,
      producer: producer == freezed
          ? _value.producer
          : producer // ignore: cast_nullable_to_non_nullable
              as String?,
      series: series == freezed
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      defective: defective == freezed
          ? _value.defective
          : defective // ignore: cast_nullable_to_non_nullable
              as int?,
      surplus: surplus == freezed
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as int?,
      underachievement: underachievement == freezed
          ? _value.underachievement
          : underachievement // ignore: cast_nullable_to_non_nullable
              as int?,
      reSorting: reSorting == freezed
          ? _value.reSorting
          : reSorting // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductDTO implements _ProductDTO {
  const _$_ProductDTO(
      {required this.id,
      @JsonKey(name: 'arrival_pharmacy_id') this.arrivalPharmacyId,
      this.name,
      this.image,
      this.barcode,
      this.status,
      @JsonKey(name: 'total_count') this.totalCount,
      @JsonKey(name: 'scan_count') this.scanCount,
      this.producer,
      this.series,
      this.defective,
      this.surplus,
      this.underachievement,
      @JsonKey(name: 're_sorting') this.reSorting,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$_ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ProductDTOFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'arrival_pharmacy_id')
  final int? arrivalPharmacyId;
  @override
  final String? name;
  @override
  final String? image;
  @override
  final String? barcode;
  @override
  final String? status;
  @override
  @JsonKey(name: 'total_count')
  final int? totalCount;
  @override
  @JsonKey(name: 'scan_count')
  final int? scanCount;
  @override
  final String? producer;
  @override
  final String? series;
  @override
  final int? defective;
  @override
  final int? surplus;
  @override
  final int? underachievement;
  @override
  @JsonKey(name: 're_sorting')
  final int? reSorting;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'ProductDTO(id: $id, arrivalPharmacyId: $arrivalPharmacyId, name: $name, image: $image, barcode: $barcode, status: $status, totalCount: $totalCount, scanCount: $scanCount, producer: $producer, series: $series, defective: $defective, surplus: $surplus, underachievement: $underachievement, reSorting: $reSorting, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductDTO &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.arrivalPharmacyId, arrivalPharmacyId) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.barcode, barcode) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.totalCount, totalCount) &&
            const DeepCollectionEquality().equals(other.scanCount, scanCount) &&
            const DeepCollectionEquality().equals(other.producer, producer) &&
            const DeepCollectionEquality().equals(other.series, series) &&
            const DeepCollectionEquality().equals(other.defective, defective) &&
            const DeepCollectionEquality().equals(other.surplus, surplus) &&
            const DeepCollectionEquality()
                .equals(other.underachievement, underachievement) &&
            const DeepCollectionEquality().equals(other.reSorting, reSorting) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(arrivalPharmacyId),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(barcode),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(totalCount),
      const DeepCollectionEquality().hash(scanCount),
      const DeepCollectionEquality().hash(producer),
      const DeepCollectionEquality().hash(series),
      const DeepCollectionEquality().hash(defective),
      const DeepCollectionEquality().hash(surplus),
      const DeepCollectionEquality().hash(underachievement),
      const DeepCollectionEquality().hash(reSorting),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_ProductDTOCopyWith<_$_ProductDTO> get copyWith =>
      __$$_ProductDTOCopyWithImpl<_$_ProductDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductDTOToJson(this);
  }
}

abstract class _ProductDTO implements ProductDTO {
  const factory _ProductDTO(
      {required final int id,
      @JsonKey(name: 'arrival_pharmacy_id') final int? arrivalPharmacyId,
      final String? name,
      final String? image,
      final String? barcode,
      final String? status,
      @JsonKey(name: 'total_count') final int? totalCount,
      @JsonKey(name: 'scan_count') final int? scanCount,
      final String? producer,
      final String? series,
      final int? defective,
      final int? surplus,
      final int? underachievement,
      @JsonKey(name: 're_sorting') final int? reSorting,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$_ProductDTO;

  factory _ProductDTO.fromJson(Map<String, dynamic> json) =
      _$_ProductDTO.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'arrival_pharmacy_id')
  int? get arrivalPharmacyId => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get image => throw _privateConstructorUsedError;
  @override
  String? get barcode => throw _privateConstructorUsedError;
  @override
  String? get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'total_count')
  int? get totalCount => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'scan_count')
  int? get scanCount => throw _privateConstructorUsedError;
  @override
  String? get producer => throw _privateConstructorUsedError;
  @override
  String? get series => throw _privateConstructorUsedError;
  @override
  int? get defective => throw _privateConstructorUsedError;
  @override
  int? get surplus => throw _privateConstructorUsedError;
  @override
  int? get underachievement => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 're_sorting')
  int? get reSorting => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ProductDTOCopyWith<_$_ProductDTO> get copyWith =>
      throw _privateConstructorUsedError;
}