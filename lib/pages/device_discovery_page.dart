import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firefighter/core/bluetooth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class DeviceDiscoveryPage extends ConsumerStatefulWidget {
  const DeviceDiscoveryPage({super.key});

  @override
  ConsumerState<DeviceDiscoveryPage> createState() => _DeviceDiscoveryPageState();
}

class _DeviceDiscoveryPageState extends ConsumerState<DeviceDiscoveryPage> {
  @override
  void initState() {
    super.initState();
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
          Consumer(
            child: const Center(child: CircularProgressIndicator()),
            builder: (context, ref, child) {
              final pairedDevices = ref.watch(pairedDevicesProvider);
              return pairedDevices.when(
                loading: () => child!,
                error: (error, stacktrace) => const Center(
                  child: Text('Something went wrong...'),
                ),
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(child: Text('No device found'));
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final device = data[index];
                        return ListTile(
                          onTap: () async {
                            final answer = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Connect to this device?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );

                            if (answer == true) {
                              await ref
                                  .read(connectedDeviceProvider.notifier)
                                  .setConnectedDevice(device)
                                  .then(
                                (_) {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                          title: Text(device.name ?? 'Unknown'),
                          subtitle: Text(device.address),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
