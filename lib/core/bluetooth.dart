import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_firefighter/core/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bluetooth.g.dart';

@riverpod
FutureOr<List<BluetoothDevice>> pairedDevices(PairedDevicesRef ref) async {
  final btConnectGranted = await Permission.bluetoothConnect.isGranted;
  if (!btConnectGranted) {
    await Permission.bluetoothConnect.request();
  }

  final btScanGranted = await Permission.bluetoothScan.isGranted;
  if (!btScanGranted) {
    await Permission.bluetoothScan.request();
  }

  await Permission.location.request();

  return FlutterBluetoothSerial.instance.getBondedDevices();
}

@riverpod
class ConnectedDevice extends _$ConnectedDevice {
  @override
  BluetoothDevice? build() {
    return null;
  }

  Future<void> getSavedDevice() async {
    final box = await Hive.openBox(appKey);
    final deviceMap = box.get(pairedDeviceKey) as Map?;
    if (deviceMap != null) {
      try {
        await setConnectedDevice(BluetoothDevice.fromMap(deviceMap));
      } catch (error) {
        box.delete(pairedDeviceKey);
      }
    }
  }

  Future<void> setConnectedDevice(BluetoothDevice device) async {
    final box = await Hive.openBox(appKey);
    await box.put(pairedDeviceKey, device.toMap());

    state = device;
  }
}

@riverpod
FutureOr<BluetoothConnection?> bluetoothConnection(
    BluetoothConnectionRef bluetoothConnectionRef) async {
  final connectedDevice = bluetoothConnectionRef.watch(connectedDeviceProvider);
  if (connectedDevice == null) {
    return null;
  }

  final connection = await BluetoothConnection.toAddress(connectedDevice.address);

  bluetoothConnectionRef.onDispose(connection.dispose);

  return connection;
}

@riverpod
Future<void> sendSerialMessage(SendSerialMessageRef ref, String message) async {
  final bluetoothConnection = await ref.watch(bluetoothConnectionProvider.future);
  if (bluetoothConnection == null) {
    return;
  }
  bluetoothConnection.output.add(Uint8List.fromList(utf8.encode("$message\r\n")));
  await bluetoothConnection.output.allSent;
}
