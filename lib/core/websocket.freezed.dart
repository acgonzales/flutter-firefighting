// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebsocketDetailsDto {
  io.Socket? get socket => throw _privateConstructorUsedError;
  EyeConnectionStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WebsocketDetailsDtoCopyWith<WebsocketDetailsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebsocketDetailsDtoCopyWith<$Res> {
  factory $WebsocketDetailsDtoCopyWith(
          WebsocketDetailsDto value, $Res Function(WebsocketDetailsDto) then) =
      _$WebsocketDetailsDtoCopyWithImpl<$Res, WebsocketDetailsDto>;
  @useResult
  $Res call({io.Socket? socket, EyeConnectionStatus status});
}

/// @nodoc
class _$WebsocketDetailsDtoCopyWithImpl<$Res, $Val extends WebsocketDetailsDto>
    implements $WebsocketDetailsDtoCopyWith<$Res> {
  _$WebsocketDetailsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? socket = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      socket: freezed == socket
          ? _value.socket
          : socket // ignore: cast_nullable_to_non_nullable
              as io.Socket?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EyeConnectionStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebsocketDetailsDtoImplCopyWith<$Res>
    implements $WebsocketDetailsDtoCopyWith<$Res> {
  factory _$$WebsocketDetailsDtoImplCopyWith(_$WebsocketDetailsDtoImpl value,
          $Res Function(_$WebsocketDetailsDtoImpl) then) =
      __$$WebsocketDetailsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({io.Socket? socket, EyeConnectionStatus status});
}

/// @nodoc
class __$$WebsocketDetailsDtoImplCopyWithImpl<$Res>
    extends _$WebsocketDetailsDtoCopyWithImpl<$Res, _$WebsocketDetailsDtoImpl>
    implements _$$WebsocketDetailsDtoImplCopyWith<$Res> {
  __$$WebsocketDetailsDtoImplCopyWithImpl(_$WebsocketDetailsDtoImpl _value,
      $Res Function(_$WebsocketDetailsDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? socket = freezed,
    Object? status = null,
  }) {
    return _then(_$WebsocketDetailsDtoImpl(
      socket: freezed == socket
          ? _value.socket
          : socket // ignore: cast_nullable_to_non_nullable
              as io.Socket?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EyeConnectionStatus,
    ));
  }
}

/// @nodoc

class _$WebsocketDetailsDtoImpl extends _WebsocketDetailsDto {
  _$WebsocketDetailsDtoImpl({required this.socket, required this.status})
      : super._();

  @override
  final io.Socket? socket;
  @override
  final EyeConnectionStatus status;

  @override
  String toString() {
    return 'WebsocketDetailsDto(socket: $socket, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebsocketDetailsDtoImpl &&
            (identical(other.socket, socket) || other.socket == socket) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, socket, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebsocketDetailsDtoImplCopyWith<_$WebsocketDetailsDtoImpl> get copyWith =>
      __$$WebsocketDetailsDtoImplCopyWithImpl<_$WebsocketDetailsDtoImpl>(
          this, _$identity);
}

abstract class _WebsocketDetailsDto extends WebsocketDetailsDto {
  factory _WebsocketDetailsDto(
      {required final io.Socket? socket,
      required final EyeConnectionStatus status}) = _$WebsocketDetailsDtoImpl;
  _WebsocketDetailsDto._() : super._();

  @override
  io.Socket? get socket;
  @override
  EyeConnectionStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$WebsocketDetailsDtoImplCopyWith<_$WebsocketDetailsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
