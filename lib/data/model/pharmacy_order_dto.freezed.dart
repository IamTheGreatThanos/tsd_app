// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pharmacy_order_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PharmacyOrderDTO _$PharmacyOrderDTOFromJson(Map<String, dynamic> json) {
  return _PharmacyOrderDTO.fromJson(json);
}

/// @nodoc
mixin _$PharmacyOrderDTO {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_id')
  int? get driverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  int? get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'recipient_id')
  int? get recipientId => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  String? get number => throw _privateConstructorUsedError;
  int? get container => throw _privateConstructorUsedError;
  @JsonKey(name: 'departure_time')
  String? get departureTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_address')
  String? get fromAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_city_name')
  String? get fromCityName => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_address')
  String? get toAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_city_name')
  String? get toCityName => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError; // int? entrance
  @JsonKey(name: 'incoming_number')
  String? get incomingNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'incoming_date')
  String? get incomingDate => throw _privateConstructorUsedError;
  String? get bin => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_date')
  String? get invoiceDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  User? get driver => throw _privateConstructorUsedError;
  CounteragentDTO? get sender => throw _privateConstructorUsedError;
  CounteragentDTO? get recipient => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_status')
  int? get totalStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'yandex_time')
  String? get yandexTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'refund_status')
  int? get refundStatus => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PharmacyOrderDTOCopyWith<PharmacyOrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PharmacyOrderDTOCopyWith<$Res> {
  factory $PharmacyOrderDTOCopyWith(
          PharmacyOrderDTO value, $Res Function(PharmacyOrderDTO) then) =
      _$PharmacyOrderDTOCopyWithImpl<$Res, PharmacyOrderDTO>;
  @useResult
  $Res call(
      {int id,
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
      String? amount,
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
      String? provider});

  $UserCopyWith<$Res>? get driver;
  $CounteragentDTOCopyWith<$Res>? get sender;
  $CounteragentDTOCopyWith<$Res>? get recipient;
}

/// @nodoc
class _$PharmacyOrderDTOCopyWithImpl<$Res, $Val extends PharmacyOrderDTO>
    implements $PharmacyOrderDTOCopyWith<$Res> {
  _$PharmacyOrderDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? driverId = freezed,
    Object? senderId = freezed,
    Object? recipientId = freezed,
    Object? status = freezed,
    Object? number = freezed,
    Object? container = freezed,
    Object? departureTime = freezed,
    Object? fromAddress = freezed,
    Object? fromCityName = freezed,
    Object? toAddress = freezed,
    Object? toCityName = freezed,
    Object? amount = freezed,
    Object? incomingNumber = freezed,
    Object? incomingDate = freezed,
    Object? bin = freezed,
    Object? invoiceDate = freezed,
    Object? createdAt = freezed,
    Object? driver = freezed,
    Object? sender = freezed,
    Object? recipient = freezed,
    Object? totalStatus = freezed,
    Object? yandexTime = freezed,
    Object? refundStatus = freezed,
    Object? provider = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      recipientId: freezed == recipientId
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      container: freezed == container
          ? _value.container
          : container // ignore: cast_nullable_to_non_nullable
              as int?,
      departureTime: freezed == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as String?,
      fromAddress: freezed == fromAddress
          ? _value.fromAddress
          : fromAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      fromCityName: freezed == fromCityName
          ? _value.fromCityName
          : fromCityName // ignore: cast_nullable_to_non_nullable
              as String?,
      toAddress: freezed == toAddress
          ? _value.toAddress
          : toAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      toCityName: freezed == toCityName
          ? _value.toCityName
          : toCityName // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingNumber: freezed == incomingNumber
          ? _value.incomingNumber
          : incomingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingDate: freezed == incomingDate
          ? _value.incomingDate
          : incomingDate // ignore: cast_nullable_to_non_nullable
              as String?,
      bin: freezed == bin
          ? _value.bin
          : bin // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceDate: freezed == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      driver: freezed == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as User?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
      recipient: freezed == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
      totalStatus: freezed == totalStatus
          ? _value.totalStatus
          : totalStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      yandexTime: freezed == yandexTime
          ? _value.yandexTime
          : yandexTime // ignore: cast_nullable_to_non_nullable
              as String?,
      refundStatus: freezed == refundStatus
          ? _value.refundStatus
          : refundStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get driver {
    if (_value.driver == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.driver!, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CounteragentDTOCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $CounteragentDTOCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CounteragentDTOCopyWith<$Res>? get recipient {
    if (_value.recipient == null) {
      return null;
    }

    return $CounteragentDTOCopyWith<$Res>(_value.recipient!, (value) {
      return _then(_value.copyWith(recipient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PharmacyOrderDTOCopyWith<$Res>
    implements $PharmacyOrderDTOCopyWith<$Res> {
  factory _$$_PharmacyOrderDTOCopyWith(
          _$_PharmacyOrderDTO value, $Res Function(_$_PharmacyOrderDTO) then) =
      __$$_PharmacyOrderDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
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
      String? amount,
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
      String? provider});

  @override
  $UserCopyWith<$Res>? get driver;
  @override
  $CounteragentDTOCopyWith<$Res>? get sender;
  @override
  $CounteragentDTOCopyWith<$Res>? get recipient;
}

/// @nodoc
class __$$_PharmacyOrderDTOCopyWithImpl<$Res>
    extends _$PharmacyOrderDTOCopyWithImpl<$Res, _$_PharmacyOrderDTO>
    implements _$$_PharmacyOrderDTOCopyWith<$Res> {
  __$$_PharmacyOrderDTOCopyWithImpl(
      _$_PharmacyOrderDTO _value, $Res Function(_$_PharmacyOrderDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? driverId = freezed,
    Object? senderId = freezed,
    Object? recipientId = freezed,
    Object? status = freezed,
    Object? number = freezed,
    Object? container = freezed,
    Object? departureTime = freezed,
    Object? fromAddress = freezed,
    Object? fromCityName = freezed,
    Object? toAddress = freezed,
    Object? toCityName = freezed,
    Object? amount = freezed,
    Object? incomingNumber = freezed,
    Object? incomingDate = freezed,
    Object? bin = freezed,
    Object? invoiceDate = freezed,
    Object? createdAt = freezed,
    Object? driver = freezed,
    Object? sender = freezed,
    Object? recipient = freezed,
    Object? totalStatus = freezed,
    Object? yandexTime = freezed,
    Object? refundStatus = freezed,
    Object? provider = freezed,
  }) {
    return _then(_$_PharmacyOrderDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      recipientId: freezed == recipientId
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      container: freezed == container
          ? _value.container
          : container // ignore: cast_nullable_to_non_nullable
              as int?,
      departureTime: freezed == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as String?,
      fromAddress: freezed == fromAddress
          ? _value.fromAddress
          : fromAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      fromCityName: freezed == fromCityName
          ? _value.fromCityName
          : fromCityName // ignore: cast_nullable_to_non_nullable
              as String?,
      toAddress: freezed == toAddress
          ? _value.toAddress
          : toAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      toCityName: freezed == toCityName
          ? _value.toCityName
          : toCityName // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingNumber: freezed == incomingNumber
          ? _value.incomingNumber
          : incomingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingDate: freezed == incomingDate
          ? _value.incomingDate
          : incomingDate // ignore: cast_nullable_to_non_nullable
              as String?,
      bin: freezed == bin
          ? _value.bin
          : bin // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceDate: freezed == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      driver: freezed == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as User?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
      recipient: freezed == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
      totalStatus: freezed == totalStatus
          ? _value.totalStatus
          : totalStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      yandexTime: freezed == yandexTime
          ? _value.yandexTime
          : yandexTime // ignore: cast_nullable_to_non_nullable
              as String?,
      refundStatus: freezed == refundStatus
          ? _value.refundStatus
          : refundStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PharmacyOrderDTO implements _PharmacyOrderDTO {
  const _$_PharmacyOrderDTO(
      {required this.id,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'driver_id') this.driverId,
      @JsonKey(name: 'sender_id') this.senderId,
      @JsonKey(name: 'recipient_id') this.recipientId,
      this.status,
      this.number,
      this.container,
      @JsonKey(name: 'departure_time') this.departureTime,
      @JsonKey(name: 'from_address') this.fromAddress,
      @JsonKey(name: 'from_city_name') this.fromCityName,
      @JsonKey(name: 'to_address') this.toAddress,
      @JsonKey(name: 'to_city_name') this.toCityName,
      this.amount,
      @JsonKey(name: 'incoming_number') this.incomingNumber,
      @JsonKey(name: 'incoming_date') this.incomingDate,
      this.bin,
      @JsonKey(name: 'invoice_date') this.invoiceDate,
      @JsonKey(name: 'created_at') this.createdAt,
      this.driver,
      this.sender,
      this.recipient,
      @JsonKey(name: 'total_status') this.totalStatus,
      @JsonKey(name: 'yandex_time') this.yandexTime,
      @JsonKey(name: 'refund_status') this.refundStatus,
      this.provider});

  factory _$_PharmacyOrderDTO.fromJson(Map<String, dynamic> json) =>
      _$$_PharmacyOrderDTOFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  @JsonKey(name: 'driver_id')
  final int? driverId;
  @override
  @JsonKey(name: 'sender_id')
  final int? senderId;
  @override
  @JsonKey(name: 'recipient_id')
  final int? recipientId;
  @override
  final int? status;
  @override
  final String? number;
  @override
  final int? container;
  @override
  @JsonKey(name: 'departure_time')
  final String? departureTime;
  @override
  @JsonKey(name: 'from_address')
  final String? fromAddress;
  @override
  @JsonKey(name: 'from_city_name')
  final String? fromCityName;
  @override
  @JsonKey(name: 'to_address')
  final String? toAddress;
  @override
  @JsonKey(name: 'to_city_name')
  final String? toCityName;
  @override
  final String? amount;
// int? entrance
  @override
  @JsonKey(name: 'incoming_number')
  final String? incomingNumber;
  @override
  @JsonKey(name: 'incoming_date')
  final String? incomingDate;
  @override
  final String? bin;
  @override
  @JsonKey(name: 'invoice_date')
  final String? invoiceDate;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  final User? driver;
  @override
  final CounteragentDTO? sender;
  @override
  final CounteragentDTO? recipient;
  @override
  @JsonKey(name: 'total_status')
  final int? totalStatus;
  @override
  @JsonKey(name: 'yandex_time')
  final String? yandexTime;
  @override
  @JsonKey(name: 'refund_status')
  final int? refundStatus;
  @override
  final String? provider;

  @override
  String toString() {
    return 'PharmacyOrderDTO(id: $id, userId: $userId, driverId: $driverId, senderId: $senderId, recipientId: $recipientId, status: $status, number: $number, container: $container, departureTime: $departureTime, fromAddress: $fromAddress, fromCityName: $fromCityName, toAddress: $toAddress, toCityName: $toCityName, amount: $amount, incomingNumber: $incomingNumber, incomingDate: $incomingDate, bin: $bin, invoiceDate: $invoiceDate, createdAt: $createdAt, driver: $driver, sender: $sender, recipient: $recipient, totalStatus: $totalStatus, yandexTime: $yandexTime, refundStatus: $refundStatus, provider: $provider)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PharmacyOrderDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.container, container) ||
                other.container == container) &&
            (identical(other.departureTime, departureTime) ||
                other.departureTime == departureTime) &&
            (identical(other.fromAddress, fromAddress) ||
                other.fromAddress == fromAddress) &&
            (identical(other.fromCityName, fromCityName) ||
                other.fromCityName == fromCityName) &&
            (identical(other.toAddress, toAddress) ||
                other.toAddress == toAddress) &&
            (identical(other.toCityName, toCityName) ||
                other.toCityName == toCityName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.incomingNumber, incomingNumber) ||
                other.incomingNumber == incomingNumber) &&
            (identical(other.incomingDate, incomingDate) ||
                other.incomingDate == incomingDate) &&
            (identical(other.bin, bin) || other.bin == bin) &&
            (identical(other.invoiceDate, invoiceDate) ||
                other.invoiceDate == invoiceDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.totalStatus, totalStatus) ||
                other.totalStatus == totalStatus) &&
            (identical(other.yandexTime, yandexTime) ||
                other.yandexTime == yandexTime) &&
            (identical(other.refundStatus, refundStatus) ||
                other.refundStatus == refundStatus) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        driverId,
        senderId,
        recipientId,
        status,
        number,
        container,
        departureTime,
        fromAddress,
        fromCityName,
        toAddress,
        toCityName,
        amount,
        incomingNumber,
        incomingDate,
        bin,
        invoiceDate,
        createdAt,
        driver,
        sender,
        recipient,
        totalStatus,
        yandexTime,
        refundStatus,
        provider
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PharmacyOrderDTOCopyWith<_$_PharmacyOrderDTO> get copyWith =>
      __$$_PharmacyOrderDTOCopyWithImpl<_$_PharmacyOrderDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PharmacyOrderDTOToJson(
      this,
    );
  }
}

abstract class _PharmacyOrderDTO implements PharmacyOrderDTO {
  const factory _PharmacyOrderDTO(
      {required final int id,
      @JsonKey(name: 'user_id') final int? userId,
      @JsonKey(name: 'driver_id') final int? driverId,
      @JsonKey(name: 'sender_id') final int? senderId,
      @JsonKey(name: 'recipient_id') final int? recipientId,
      final int? status,
      final String? number,
      final int? container,
      @JsonKey(name: 'departure_time') final String? departureTime,
      @JsonKey(name: 'from_address') final String? fromAddress,
      @JsonKey(name: 'from_city_name') final String? fromCityName,
      @JsonKey(name: 'to_address') final String? toAddress,
      @JsonKey(name: 'to_city_name') final String? toCityName,
      final String? amount,
      @JsonKey(name: 'incoming_number') final String? incomingNumber,
      @JsonKey(name: 'incoming_date') final String? incomingDate,
      final String? bin,
      @JsonKey(name: 'invoice_date') final String? invoiceDate,
      @JsonKey(name: 'created_at') final String? createdAt,
      final User? driver,
      final CounteragentDTO? sender,
      final CounteragentDTO? recipient,
      @JsonKey(name: 'total_status') final int? totalStatus,
      @JsonKey(name: 'yandex_time') final String? yandexTime,
      @JsonKey(name: 'refund_status') final int? refundStatus,
      final String? provider}) = _$_PharmacyOrderDTO;

  factory _PharmacyOrderDTO.fromJson(Map<String, dynamic> json) =
      _$_PharmacyOrderDTO.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  @JsonKey(name: 'driver_id')
  int? get driverId;
  @override
  @JsonKey(name: 'sender_id')
  int? get senderId;
  @override
  @JsonKey(name: 'recipient_id')
  int? get recipientId;
  @override
  int? get status;
  @override
  String? get number;
  @override
  int? get container;
  @override
  @JsonKey(name: 'departure_time')
  String? get departureTime;
  @override
  @JsonKey(name: 'from_address')
  String? get fromAddress;
  @override
  @JsonKey(name: 'from_city_name')
  String? get fromCityName;
  @override
  @JsonKey(name: 'to_address')
  String? get toAddress;
  @override
  @JsonKey(name: 'to_city_name')
  String? get toCityName;
  @override
  String? get amount;
  @override // int? entrance
  @JsonKey(name: 'incoming_number')
  String? get incomingNumber;
  @override
  @JsonKey(name: 'incoming_date')
  String? get incomingDate;
  @override
  String? get bin;
  @override
  @JsonKey(name: 'invoice_date')
  String? get invoiceDate;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  User? get driver;
  @override
  CounteragentDTO? get sender;
  @override
  CounteragentDTO? get recipient;
  @override
  @JsonKey(name: 'total_status')
  int? get totalStatus;
  @override
  @JsonKey(name: 'yandex_time')
  String? get yandexTime;
  @override
  @JsonKey(name: 'refund_status')
  int? get refundStatus;
  @override
  String? get provider;
  @override
  @JsonKey(ignore: true)
  _$$_PharmacyOrderDTOCopyWith<_$_PharmacyOrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
