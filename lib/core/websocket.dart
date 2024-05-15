import 'dart:typed_data';

import 'package:flutter_firefighter/core/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'websocket.g.dart';
part 'websocket.freezed.dart';

enum EyeConnectionStatus {
  disconnected,
  connected,
  failed,
}

@freezed
class WebsocketDetailsDto with _$WebsocketDetailsDto {
  factory WebsocketDetailsDto({
    required io.Socket? socket,
    required EyeConnectionStatus status,
  }) = _WebsocketDetailsDto;

  const WebsocketDetailsDto._();
}

@Riverpod(keepAlive: true)
class WebsocketDetails extends _$WebsocketDetails {
  @override
  WebsocketDetailsDto build() {
    return WebsocketDetailsDto(
      status: EyeConnectionStatus.disconnected,
      socket: null,
    );
  }

  void connect(String url) {
    final socket = io.io(
        url,
        io.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());

    socket.onConnect(_onConnect);
    socket.onDisconnect(_onDisconnect);
    socket.onError(_onError);

    state = state.copyWith(socket: socket);
  }

  void _onConnect(_) {
    state = state.copyWith(status: EyeConnectionStatus.connected);
  }

  void _onError(error) {
    state = state.copyWith(status: EyeConnectionStatus.failed);
  }

  void _onDisconnect(_) {
    state = state.copyWith(status: EyeConnectionStatus.disconnected);
  }

  void _addCallback(String event, void Function(dynamic) callback) {
    state.socket?.on(event, callback);
  }

  void _sendMessage(String event, dynamic data) {
    state.socket?.emit(event, data);
  }

  void addNewFrameCallback(void Function(dynamic) callback) {
    _addCallback('frame', callback);
  }

  void addNewSerialCallback(void Function(dynamic) callback) {
    _addCallback('serial', callback);
  }

  void addNewAnnouncerCallback(void Function(dynamic) callback) {
    _addCallback('announcer', callback);
  }

  void sendNewFrame(Uint8List data) {
    if (state.status == EyeConnectionStatus.connected) {
      _sendMessage('raw_frame', data);
    }
  }
}
