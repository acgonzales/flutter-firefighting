import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluetooth.g.dart';
part 'bluetooth.freezed.dart';

enum BluetoothStatus { disabled, available, connected }

@freezed
class Bluetooth with _$Bluetooth {
  factory Bluetooth({
    required BluetoothStatus status,
    required BluetoothDevice? connectedDevice,
  }) = _Bluetooth;

  const Bluetooth._();
}

@riverpod
class BluetoothNotifier extends _$BluetoothNotifier {
  @override
  Future<Bluetooth> build() async {
    final enabled = await FlutterBluetoothSerial.instance.isEnabled;
    return Bluetooth(
      status: enabled != true ? BluetoothStatus.disabled : BluetoothStatus.available,
      connectedDevice: null,
    );
  }

  Future<void> requestPermissions() async {
    final result = await FlutterBluetoothSerial.instance.requestEnable();

    if (result == true) {
      final data = state.value!;
      state = AsyncData(data.copyWith(status: BluetoothStatus.available));
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    final data = state.value!;
    state = AsyncData(
      data.copyWith(
        connectedDevice: device,
        status: BluetoothStatus.connected,
      ),
    );
  }
}
