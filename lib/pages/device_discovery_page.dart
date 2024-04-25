import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_firefighter/core/bluetooth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceDiscoveryPage extends ConsumerStatefulWidget {
  const DeviceDiscoveryPage({super.key});

  @override
  ConsumerState<DeviceDiscoveryPage> createState() => _DeviceDiscoveryPageState();
}

class _DeviceDiscoveryPageState extends ConsumerState<DeviceDiscoveryPage> {
  List<BluetoothDevice>? _devices = null;

  @override
  void initState() {
    super.initState();

    Future.wait([
      Permission.bluetoothConnect.request(),
      Permission.bluetoothScan.request(),
    ]).then((_) {
      return {
        FlutterBluetoothSerial.instance
            .getBondedDevices()
            .then((List<BluetoothDevice> bondedDevices) {
          setState(() {
            _devices = bondedDevices;
          });
        })
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Device Discovery'),
      ),
      body: PaddedColumn(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('You may want to look for a device named "HC-05"'),
          const Gap(8),
          Expanded(
            child: _devices == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _devices!.length,
                    itemBuilder: (context, index) {
                      final device = _devices![index];
                      return Consumer(builder: (context, ref, _) {
                        return ListTile(
                          onTap: () {
                            ref
                                .read(bluetoothNotifierProvider.notifier)
                                .connectToDevice(device)
                                .then((value) {
                              Navigator.of(context).pop();
                            });
                          },
                          title: Text(device.name ?? 'Unknown'),
                          subtitle: Text(device.address),
                        );
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
