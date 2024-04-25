// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluetooth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Bluetooth {
  BluetoothStatus get status => throw _privateConstructorUsedError;
  BluetoothDevice? get connectedDevice => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BluetoothCopyWith<Bluetooth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothCopyWith<$Res> {
  factory $BluetoothCopyWith(Bluetooth value, $Res Function(Bluetooth) then) =
      _$BluetoothCopyWithImpl<$Res, Bluetooth>;
  @useResult
  $Res call({BluetoothStatus status, BluetoothDevice? connectedDevice});
}

/// @nodoc
class _$BluetoothCopyWithImpl<$Res, $Val extends Bluetooth>
    implements $BluetoothCopyWith<$Res> {
  _$BluetoothCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? connectedDevice = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BluetoothStatus,
      connectedDevice: freezed == connectedDevice
          ? _value.connectedDevice
          : connectedDevice // ignore: cast_nullable_to_non_nullable
              as BluetoothDevice?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BluetoothImplCopyWith<$Res>
    implements $BluetoothCopyWith<$Res> {
  factory _$$BluetoothImplCopyWith(
          _$BluetoothImpl value, $Res Function(_$BluetoothImpl) then) =
      __$$BluetoothImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BluetoothStatus status, BluetoothDevice? connectedDevice});
}

/// @nodoc
class __$$BluetoothImplCopyWithImpl<$Res>
    extends _$BluetoothCopyWithImpl<$Res, _$BluetoothImpl>
    implements _$$BluetoothImplCopyWith<$Res> {
  __$$BluetoothImplCopyWithImpl(
      _$BluetoothImpl _value, $Res Function(_$BluetoothImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? connectedDevice = freezed,
  }) {
    return _then(_$BluetoothImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BluetoothStatus,
      connectedDevice: freezed == connectedDevice
          ? _value.connectedDevice
          : connectedDevice // ignore: cast_nullable_to_non_nullable
              as BluetoothDevice?,
    ));
  }
}

/// @nodoc

class _$BluetoothImpl extends _Bluetooth {
  _$BluetoothImpl({required this.status, required this.connectedDevice})
      : super._();

  @override
  final BluetoothStatus status;
  @override
  final BluetoothDevice? connectedDevice;

  @override
  String toString() {
    return 'Bluetooth(status: $status, connectedDevice: $connectedDevice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BluetoothImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.connectedDevice, connectedDevice) ||
                other.connectedDevice == connectedDevice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, connectedDevice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BluetoothImplCopyWith<_$BluetoothImpl> get copyWith =>
      __$$BluetoothImplCopyWithImpl<_$BluetoothImpl>(this, _$identity);
}

abstract class _Bluetooth extends Bluetooth {
  factory _Bluetooth(
      {required final BluetoothStatus status,
      required final BluetoothDevice? connectedDevice}) = _$BluetoothImpl;
  _Bluetooth._() : super._();

  @override
  BluetoothStatus get status;
  @override
  BluetoothDevice? get connectedDevice;
  @override
  @JsonKey(ignore: true)
  _$$BluetoothImplCopyWith<_$BluetoothImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
