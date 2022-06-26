// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  int? get amount => throw _privateConstructorUsedError; // int? entrance
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PharmacyOrderDTOCopyWith<PharmacyOrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PharmacyOrderDTOCopyWith<$Res> {
  factory $PharmacyOrderDTOCopyWith(
          PharmacyOrderDTO value, $Res Function(PharmacyOrderDTO) then) =
      _$PharmacyOrderDTOCopyWithImpl<$Res>;
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
      int? amount,
      @JsonKey(name: 'incoming_number') String? incomingNumber,
      @JsonKey(name: 'incoming_date') String? incomingDate,
      String? bin,
      @JsonKey(name: 'invoice_date') String? invoiceDate,
      @JsonKey(name: 'created_at') String? createdAt,
      User? driver,
      CounteragentDTO? sender,
      CounteragentDTO? recipient,
      @JsonKey(name: 'total_status') int? totalStatus,
      @JsonKey(name: 'yandex_time') String? yandexTime});

  $UserCopyWith<$Res>? get driver;
  $CounteragentDTOCopyWith<$Res>? get sender;
  $CounteragentDTOCopyWith<$Res>? get recipient;
}

/// @nodoc
class _$PharmacyOrderDTOCopyWithImpl<$Res>
    implements $PharmacyOrderDTOCopyWith<$Res> {
  _$PharmacyOrderDTOCopyWithImpl(this._value, this._then);

  final PharmacyOrderDTO _value;
  // ignore: unused_field
  final $Res Function(PharmacyOrderDTO) _then;

  @override
  $Res call({
    Object? id = freezed,
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
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      driverId: driverId == freezed
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int?,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      recipientId: recipientId == freezed
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      container: container == freezed
          ? _value.container
          : container // ignore: cast_nullable_to_non_nullable
              as int?,
      departureTime: departureTime == freezed
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as String?,
      fromAddress: fromAddress == freezed
          ? _value.fromAddress
          : fromAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      fromCityName: fromCityName == freezed
          ? _value.fromCityName
          : fromCityName // ignore: cast_nullable_to_non_nullable
              as String?,
      toAddress: toAddress == freezed
          ? _value.toAddress
          : toAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      toCityName: toCityName == freezed
          ? _value.toCityName
          : toCityName // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      incomingNumber: incomingNumber == freezed
          ? _value.incomingNumber
          : incomingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingDate: incomingDate == freezed
          ? _value.incomingDate
          : incomingDate // ignore: cast_nullable_to_non_nullable
              as String?,
      bin: bin == freezed
          ? _value.bin
          : bin // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceDate: invoiceDate == freezed
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      driver: driver == freezed
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as User?,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
      recipient: recipient == freezed
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
      totalStatus: totalStatus == freezed
          ? _value.totalStatus
          : totalStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      yandexTime: yandexTime == freezed
          ? _value.yandexTime
          : yandexTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $UserCopyWith<$Res>? get driver {
    if (_value.driver == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.driver!, (value) {
      return _then(_value.copyWith(driver: value));
    });
  }

  @override
  $CounteragentDTOCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $CounteragentDTOCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value));
    });
  }

  @override
  $CounteragentDTOCopyWith<$Res>? get recipient {
    if (_value.recipient == null) {
      return null;
    }

    return $CounteragentDTOCopyWith<$Res>(_value.recipient!, (value) {
      return _then(_value.copyWith(recipient: value));
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
      int? amount,
      @JsonKey(name: 'incoming_number') String? incomingNumber,
      @JsonKey(name: 'incoming_date') String? incomingDate,
      String? bin,
      @JsonKey(name: 'invoice_date') String? invoiceDate,
      @JsonKey(name: 'created_at') String? createdAt,
      User? driver,
      CounteragentDTO? sender,
      CounteragentDTO? recipient,
      @JsonKey(name: 'total_status') int? totalStatus,
      @JsonKey(name: 'yandex_time') String? yandexTime});

  @override
  $UserCopyWith<$Res>? get driver;
  @override
  $CounteragentDTOCopyWith<$Res>? get sender;
  @override
  $CounteragentDTOCopyWith<$Res>? get recipient;
}

/// @nodoc
class __$$_PharmacyOrderDTOCopyWithImpl<$Res>
    extends _$PharmacyOrderDTOCopyWithImpl<$Res>
    implements _$$_PharmacyOrderDTOCopyWith<$Res> {
  __$$_PharmacyOrderDTOCopyWithImpl(
      _$_PharmacyOrderDTO _value, $Res Function(_$_PharmacyOrderDTO) _then)
      : super(_value, (v) => _then(v as _$_PharmacyOrderDTO));

  @override
  _$_PharmacyOrderDTO get _value => super._value as _$_PharmacyOrderDTO;

  @override
  $Res call({
    Object? id = freezed,
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
  }) {
    return _then(_$_PharmacyOrderDTO(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      driverId: driverId == freezed
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as int?,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      recipientId: recipientId == freezed
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      container: container == freezed
          ? _value.container
          : container // ignore: cast_nullable_to_non_nullable
              as int?,
      departureTime: departureTime == freezed
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as String?,
      fromAddress: fromAddress == freezed
          ? _value.fromAddress
          : fromAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      fromCityName: fromCityName == freezed
          ? _value.fromCityName
          : fromCityName // ignore: cast_nullable_to_non_nullable
              as String?,
      toAddress: toAddress == freezed
          ? _value.toAddress
          : toAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      toCityName: toCityName == freezed
          ? _value.toCityName
          : toCityName // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      incomingNumber: incomingNumber == freezed
          ? _value.incomingNumber
          : incomingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingDate: incomingDate == freezed
          ? _value.incomingDate
          : incomingDate // ignore: cast_nullable_to_non_nullable
              as String?,
      bin: bin == freezed
          ? _value.bin
          : bin // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceDate: invoiceDate == freezed
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      driver: driver == freezed
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as User?,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
      recipient: recipient == freezed
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as CounteragentDTO?,
      totalStatus: totalStatus == freezed
          ? _value.totalStatus
          : totalStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      yandexTime: yandexTime == freezed
          ? _value.yandexTime
          : yandexTime // ignore: cast_nullable_to_non_nullable
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
      @JsonKey(name: 'yandex_time') this.yandexTime});

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
  final int? amount;
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
  String toString() {
    return 'PharmacyOrderDTO(id: $id, userId: $userId, driverId: $driverId, senderId: $senderId, recipientId: $recipientId, status: $status, number: $number, container: $container, departureTime: $departureTime, fromAddress: $fromAddress, fromCityName: $fromCityName, toAddress: $toAddress, toCityName: $toCityName, amount: $amount, incomingNumber: $incomingNumber, incomingDate: $incomingDate, bin: $bin, invoiceDate: $invoiceDate, createdAt: $createdAt, driver: $driver, sender: $sender, recipient: $recipient, totalStatus: $totalStatus, yandexTime: $yandexTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PharmacyOrderDTO &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.driverId, driverId) &&
            const DeepCollectionEquality().equals(other.senderId, senderId) &&
            const DeepCollectionEquality()
                .equals(other.recipientId, recipientId) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality().equals(other.container, container) &&
            const DeepCollectionEquality()
                .equals(other.departureTime, departureTime) &&
            const DeepCollectionEquality()
                .equals(other.fromAddress, fromAddress) &&
            const DeepCollectionEquality()
                .equals(other.fromCityName, fromCityName) &&
            const DeepCollectionEquality().equals(other.toAddress, toAddress) &&
            const DeepCollectionEquality()
                .equals(other.toCityName, toCityName) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality()
                .equals(other.incomingNumber, incomingNumber) &&
            const DeepCollectionEquality()
                .equals(other.incomingDate, incomingDate) &&
            const DeepCollectionEquality().equals(other.bin, bin) &&
            const DeepCollectionEquality()
                .equals(other.invoiceDate, invoiceDate) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.driver, driver) &&
            const DeepCollectionEquality().equals(other.sender, sender) &&
            const DeepCollectionEquality().equals(other.recipient, recipient) &&
            const DeepCollectionEquality()
                .equals(other.totalStatus, totalStatus) &&
            const DeepCollectionEquality()
                .equals(other.yandexTime, yandexTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(userId),
        const DeepCollectionEquality().hash(driverId),
        const DeepCollectionEquality().hash(senderId),
        const DeepCollectionEquality().hash(recipientId),
        const DeepCollectionEquality().hash(status),
        const DeepCollectionEquality().hash(number),
        const DeepCollectionEquality().hash(container),
        const DeepCollectionEquality().hash(departureTime),
        const DeepCollectionEquality().hash(fromAddress),
        const DeepCollectionEquality().hash(fromCityName),
        const DeepCollectionEquality().hash(toAddress),
        const DeepCollectionEquality().hash(toCityName),
        const DeepCollectionEquality().hash(amount),
        const DeepCollectionEquality().hash(incomingNumber),
        const DeepCollectionEquality().hash(incomingDate),
        const DeepCollectionEquality().hash(bin),
        const DeepCollectionEquality().hash(invoiceDate),
        const DeepCollectionEquality().hash(createdAt),
        const DeepCollectionEquality().hash(driver),
        const DeepCollectionEquality().hash(sender),
        const DeepCollectionEquality().hash(recipient),
        const DeepCollectionEquality().hash(totalStatus),
        const DeepCollectionEquality().hash(yandexTime)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_PharmacyOrderDTOCopyWith<_$_PharmacyOrderDTO> get copyWith =>
      __$$_PharmacyOrderDTOCopyWithImpl<_$_PharmacyOrderDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PharmacyOrderDTOToJson(this);
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
          final int? amount,
          @JsonKey(name: 'incoming_number') final String? incomingNumber,
          @JsonKey(name: 'incoming_date') final String? incomingDate,
          final String? bin,
          @JsonKey(name: 'invoice_date') final String? invoiceDate,
          @JsonKey(name: 'created_at') final String? createdAt,
          final User? driver,
          final CounteragentDTO? sender,
          final CounteragentDTO? recipient,
          @JsonKey(name: 'total_status') final int? totalStatus,
          @JsonKey(name: 'yandex_time') final String? yandexTime}) =
      _$_PharmacyOrderDTO;

  factory _PharmacyOrderDTO.fromJson(Map<String, dynamic> json) =
      _$_PharmacyOrderDTO.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'driver_id')
  int? get driverId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'sender_id')
  int? get senderId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'recipient_id')
  int? get recipientId => throw _privateConstructorUsedError;
  @override
  int? get status => throw _privateConstructorUsedError;
  @override
  String? get number => throw _privateConstructorUsedError;
  @override
  int? get container => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'departure_time')
  String? get departureTime => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'from_address')
  String? get fromAddress => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'from_city_name')
  String? get fromCityName => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'to_address')
  String? get toAddress => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'to_city_name')
  String? get toCityName => throw _privateConstructorUsedError;
  @override
  int? get amount => throw _privateConstructorUsedError;
  @override // int? entrance
  @JsonKey(name: 'incoming_number')
  String? get incomingNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'incoming_date')
  String? get incomingDate => throw _privateConstructorUsedError;
  @override
  String? get bin => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'invoice_date')
  String? get invoiceDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @override
  User? get driver => throw _privateConstructorUsedError;
  @override
  CounteragentDTO? get sender => throw _privateConstructorUsedError;
  @override
  CounteragentDTO? get recipient => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'total_status')
  int? get totalStatus => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'yandex_time')
  String? get yandexTime => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PharmacyOrderDTOCopyWith<_$_PharmacyOrderDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
