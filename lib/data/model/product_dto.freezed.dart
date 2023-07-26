// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  @JsonKey(name: 'moving_id')
  int? get movingId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_count')
  int? get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'scan_count')
  double? get scanCount => throw _privateConstructorUsedError;
  String? get producer => throw _privateConstructorUsedError;
  String? get series => throw _privateConstructorUsedError;
  @JsonKey(name: 'serial_code')
  String? get serialCode => throw _privateConstructorUsedError;
  int? get defective => throw _privateConstructorUsedError;
  int? get surplus => throw _privateConstructorUsedError;
  int? get underachievement => throw _privateConstructorUsedError;
  @JsonKey(name: 're_sorting')
  int? get reSorting => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  bool? get isReady => throw _privateConstructorUsedError;
  int? get orderID => throw _privateConstructorUsedError;
  int? get overdue => throw _privateConstructorUsedError;
  int? get netovar => throw _privateConstructorUsedError;
  int? get refund => throw _privateConstructorUsedError;
  @JsonKey(name: 'wrong_time')
  int? get srok => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductDTOCopyWith<ProductDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDTOCopyWith<$Res> {
  factory $ProductDTOCopyWith(
          ProductDTO value, $Res Function(ProductDTO) then) =
      _$ProductDTOCopyWithImpl<$Res, ProductDTO>;
  @useResult
  $Res call(
      {int id,
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
      @JsonKey(name: 'wrong_time') int? srok});
}

/// @nodoc
class _$ProductDTOCopyWithImpl<$Res, $Val extends ProductDTO>
    implements $ProductDTOCopyWith<$Res> {
  _$ProductDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? arrivalPharmacyId = freezed,
    Object? movingId = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? barcode = freezed,
    Object? status = freezed,
    Object? totalCount = freezed,
    Object? scanCount = freezed,
    Object? producer = freezed,
    Object? series = freezed,
    Object? serialCode = freezed,
    Object? defective = freezed,
    Object? surplus = freezed,
    Object? underachievement = freezed,
    Object? reSorting = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isReady = freezed,
    Object? orderID = freezed,
    Object? overdue = freezed,
    Object? netovar = freezed,
    Object? refund = freezed,
    Object? srok = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      arrivalPharmacyId: freezed == arrivalPharmacyId
          ? _value.arrivalPharmacyId
          : arrivalPharmacyId // ignore: cast_nullable_to_non_nullable
              as int?,
      movingId: freezed == movingId
          ? _value.movingId
          : movingId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
      scanCount: freezed == scanCount
          ? _value.scanCount
          : scanCount // ignore: cast_nullable_to_non_nullable
              as double?,
      producer: freezed == producer
          ? _value.producer
          : producer // ignore: cast_nullable_to_non_nullable
              as String?,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      serialCode: freezed == serialCode
          ? _value.serialCode
          : serialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      defective: freezed == defective
          ? _value.defective
          : defective // ignore: cast_nullable_to_non_nullable
              as int?,
      surplus: freezed == surplus
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as int?,
      underachievement: freezed == underachievement
          ? _value.underachievement
          : underachievement // ignore: cast_nullable_to_non_nullable
              as int?,
      reSorting: freezed == reSorting
          ? _value.reSorting
          : reSorting // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isReady: freezed == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool?,
      orderID: freezed == orderID
          ? _value.orderID
          : orderID // ignore: cast_nullable_to_non_nullable
              as int?,
      overdue: freezed == overdue
          ? _value.overdue
          : overdue // ignore: cast_nullable_to_non_nullable
              as int?,
      netovar: freezed == netovar
          ? _value.netovar
          : netovar // ignore: cast_nullable_to_non_nullable
              as int?,
      refund: freezed == refund
          ? _value.refund
          : refund // ignore: cast_nullable_to_non_nullable
              as int?,
      srok: freezed == srok
          ? _value.srok
          : srok // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductDTOCopyWith<$Res>
    implements $ProductDTOCopyWith<$Res> {
  factory _$$_ProductDTOCopyWith(
          _$_ProductDTO value, $Res Function(_$_ProductDTO) then) =
      __$$_ProductDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
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
      @JsonKey(name: 'wrong_time') int? srok});
}

/// @nodoc
class __$$_ProductDTOCopyWithImpl<$Res>
    extends _$ProductDTOCopyWithImpl<$Res, _$_ProductDTO>
    implements _$$_ProductDTOCopyWith<$Res> {
  __$$_ProductDTOCopyWithImpl(
      _$_ProductDTO _value, $Res Function(_$_ProductDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? arrivalPharmacyId = freezed,
    Object? movingId = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? barcode = freezed,
    Object? status = freezed,
    Object? totalCount = freezed,
    Object? scanCount = freezed,
    Object? producer = freezed,
    Object? series = freezed,
    Object? serialCode = freezed,
    Object? defective = freezed,
    Object? surplus = freezed,
    Object? underachievement = freezed,
    Object? reSorting = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isReady = freezed,
    Object? orderID = freezed,
    Object? overdue = freezed,
    Object? netovar = freezed,
    Object? refund = freezed,
    Object? srok = freezed,
  }) {
    return _then(_$_ProductDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      arrivalPharmacyId: freezed == arrivalPharmacyId
          ? _value.arrivalPharmacyId
          : arrivalPharmacyId // ignore: cast_nullable_to_non_nullable
              as int?,
      movingId: freezed == movingId
          ? _value.movingId
          : movingId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
      scanCount: freezed == scanCount
          ? _value.scanCount
          : scanCount // ignore: cast_nullable_to_non_nullable
              as double?,
      producer: freezed == producer
          ? _value.producer
          : producer // ignore: cast_nullable_to_non_nullable
              as String?,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      serialCode: freezed == serialCode
          ? _value.serialCode
          : serialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      defective: freezed == defective
          ? _value.defective
          : defective // ignore: cast_nullable_to_non_nullable
              as int?,
      surplus: freezed == surplus
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as int?,
      underachievement: freezed == underachievement
          ? _value.underachievement
          : underachievement // ignore: cast_nullable_to_non_nullable
              as int?,
      reSorting: freezed == reSorting
          ? _value.reSorting
          : reSorting // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isReady: freezed == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool?,
      orderID: freezed == orderID
          ? _value.orderID
          : orderID // ignore: cast_nullable_to_non_nullable
              as int?,
      overdue: freezed == overdue
          ? _value.overdue
          : overdue // ignore: cast_nullable_to_non_nullable
              as int?,
      netovar: freezed == netovar
          ? _value.netovar
          : netovar // ignore: cast_nullable_to_non_nullable
              as int?,
      refund: freezed == refund
          ? _value.refund
          : refund // ignore: cast_nullable_to_non_nullable
              as int?,
      srok: freezed == srok
          ? _value.srok
          : srok // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductDTO implements _ProductDTO {
  const _$_ProductDTO(
      {required this.id,
      @JsonKey(name: 'arrival_pharmacy_id') this.arrivalPharmacyId,
      @JsonKey(name: 'moving_id') this.movingId,
      this.name,
      this.image,
      this.barcode,
      this.status,
      @JsonKey(name: 'total_count') this.totalCount,
      @JsonKey(name: 'scan_count') this.scanCount,
      this.producer,
      this.series,
      @JsonKey(name: 'serial_code') this.serialCode,
      this.defective,
      this.surplus,
      this.underachievement,
      @JsonKey(name: 're_sorting') this.reSorting,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.isReady,
      this.orderID,
      this.overdue,
      this.netovar,
      this.refund,
      @JsonKey(name: 'wrong_time') this.srok});

  factory _$_ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ProductDTOFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'arrival_pharmacy_id')
  final int? arrivalPharmacyId;
  @override
  @JsonKey(name: 'moving_id')
  final int? movingId;
  @override
  final String? name;
  @override
  final String? image;
  @override
  final String? barcode;
  @override
  final int? status;
  @override
  @JsonKey(name: 'total_count')
  final int? totalCount;
  @override
  @JsonKey(name: 'scan_count')
  final double? scanCount;
  @override
  final String? producer;
  @override
  final String? series;
  @override
  @JsonKey(name: 'serial_code')
  final String? serialCode;
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
  final bool? isReady;
  @override
  final int? orderID;
  @override
  final int? overdue;
  @override
  final int? netovar;
  @override
  final int? refund;
  @override
  @JsonKey(name: 'wrong_time')
  final int? srok;

  @override
  String toString() {
    return 'ProductDTO(id: $id, arrivalPharmacyId: $arrivalPharmacyId, movingId: $movingId, name: $name, image: $image, barcode: $barcode, status: $status, totalCount: $totalCount, scanCount: $scanCount, producer: $producer, series: $series, serialCode: $serialCode, defective: $defective, surplus: $surplus, underachievement: $underachievement, reSorting: $reSorting, createdAt: $createdAt, updatedAt: $updatedAt, isReady: $isReady, orderID: $orderID, overdue: $overdue, netovar: $netovar, refund: $refund, srok: $srok)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.arrivalPharmacyId, arrivalPharmacyId) ||
                other.arrivalPharmacyId == arrivalPharmacyId) &&
            (identical(other.movingId, movingId) ||
                other.movingId == movingId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.scanCount, scanCount) ||
                other.scanCount == scanCount) &&
            (identical(other.producer, producer) ||
                other.producer == producer) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.serialCode, serialCode) ||
                other.serialCode == serialCode) &&
            (identical(other.defective, defective) ||
                other.defective == defective) &&
            (identical(other.surplus, surplus) || other.surplus == surplus) &&
            (identical(other.underachievement, underachievement) ||
                other.underachievement == underachievement) &&
            (identical(other.reSorting, reSorting) ||
                other.reSorting == reSorting) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isReady, isReady) || other.isReady == isReady) &&
            (identical(other.orderID, orderID) || other.orderID == orderID) &&
            (identical(other.overdue, overdue) || other.overdue == overdue) &&
            (identical(other.netovar, netovar) || other.netovar == netovar) &&
            (identical(other.refund, refund) || other.refund == refund) &&
            (identical(other.srok, srok) || other.srok == srok));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        arrivalPharmacyId,
        movingId,
        name,
        image,
        barcode,
        status,
        totalCount,
        scanCount,
        producer,
        series,
        serialCode,
        defective,
        surplus,
        underachievement,
        reSorting,
        createdAt,
        updatedAt,
        isReady,
        orderID,
        overdue,
        netovar,
        refund,
        srok
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductDTOCopyWith<_$_ProductDTO> get copyWith =>
      __$$_ProductDTOCopyWithImpl<_$_ProductDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductDTOToJson(
      this,
    );
  }
}

abstract class _ProductDTO implements ProductDTO {
  const factory _ProductDTO(
      {required final int id,
      @JsonKey(name: 'arrival_pharmacy_id') final int? arrivalPharmacyId,
      @JsonKey(name: 'moving_id') final int? movingId,
      final String? name,
      final String? image,
      final String? barcode,
      final int? status,
      @JsonKey(name: 'total_count') final int? totalCount,
      @JsonKey(name: 'scan_count') final double? scanCount,
      final String? producer,
      final String? series,
      @JsonKey(name: 'serial_code') final String? serialCode,
      final int? defective,
      final int? surplus,
      final int? underachievement,
      @JsonKey(name: 're_sorting') final int? reSorting,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final bool? isReady,
      final int? orderID,
      final int? overdue,
      final int? netovar,
      final int? refund,
      @JsonKey(name: 'wrong_time') final int? srok}) = _$_ProductDTO;

  factory _ProductDTO.fromJson(Map<String, dynamic> json) =
      _$_ProductDTO.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'arrival_pharmacy_id')
  int? get arrivalPharmacyId;
  @override
  @JsonKey(name: 'moving_id')
  int? get movingId;
  @override
  String? get name;
  @override
  String? get image;
  @override
  String? get barcode;
  @override
  int? get status;
  @override
  @JsonKey(name: 'total_count')
  int? get totalCount;
  @override
  @JsonKey(name: 'scan_count')
  double? get scanCount;
  @override
  String? get producer;
  @override
  String? get series;
  @override
  @JsonKey(name: 'serial_code')
  String? get serialCode;
  @override
  int? get defective;
  @override
  int? get surplus;
  @override
  int? get underachievement;
  @override
  @JsonKey(name: 're_sorting')
  int? get reSorting;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  bool? get isReady;
  @override
  int? get orderID;
  @override
  int? get overdue;
  @override
  int? get netovar;
  @override
  int? get refund;
  @override
  @JsonKey(name: 'wrong_time')
  int? get srok;
  @override
  @JsonKey(ignore: true)
  _$$_ProductDTOCopyWith<_$_ProductDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
