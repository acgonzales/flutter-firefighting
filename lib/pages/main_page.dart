import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firefighter/core/bluetooth.dart';
import 'package:flutter_firefighter/core/camera.dart';
import 'package:flutter_firefighter/core/websocket.dart';
import 'package:flutter_firefighter/pages/device_discovery_page.dart';
import 'package:flutter_firefighter/pages/sheets/connect_server_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  bool _loading = true;

  Uint8List? _currentFrame;

  late TextEditingController _textEditingController;

  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();

    ref.read(websocketDetailsProvider);
    _initialize();
  }

  Future<void> _initialize() async {
    ref.read(connectedDeviceProvider.notifier).getSavedDevice();
    ref.read(availableCamerasProvider.future).then(
          (cameras) => {
            _cameraController = CameraController(
              cameras[0],
              ResolutionPreset.high,
              enableAudio: false,
            ),
            _cameraController.initialize().then((_) async {
              if (!mounted) return;

              setState(() {
                _loading = false;
              });

              await _cameraController.setFlashMode(FlashMode.off);
              await _cameraController.lockCaptureOrientation(DeviceOrientation.portraitUp);

              Timer.periodic(const Duration(milliseconds: 200), (timer) async {
                final status = ref.read(websocketDetailsProvider.select((value) => value.status));
                if (status == EyeConnectionStatus.connected) {
                  final image = await _cameraController.takePicture();
                  final bytes = await image.readAsBytes();
                  ref.read(websocketDetailsProvider.notifier).sendNewFrame(bytes);
                }
              });
            })
          },
        );
  }

  Widget loadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget mainScreen() {
    ref.listen(websocketDetailsProvider.select((value) => value.status), (previous, next) {
      if (next == EyeConnectionStatus.connected) {
        ref.read(websocketDetailsProvider.notifier).addNewFrameCallback((data) {
          setState(() {
            _currentFrame = data;
          });
        });

        ref.read(websocketDetailsProvider.notifier).addNewSerialCallback((data) {
          final command = data as String;
          ref.read(sendSerialMessageProvider(command));
        });

        ref.read(websocketDetailsProvider.notifier).addNewAnnouncerCallback((data) {
          final message = data as String;
          _textEditingController.text = "$message\n${_textEditingController.text}";
        });
      }
    });

    return PaddedColumn(
      padding: const EdgeInsets.all(16),
      children: [
        _cameraController.value.isInitialized && _currentFrame != null
            ? Card(
                child: SizedBox(
                  width: double.infinity,
                  height: 180.0,
                  child: Center(
                    child: Image.memory(_currentFrame!),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        const Gap(8),
        Card(
          child: PaddedColumn(
            padding: const EdgeInsets.all(16),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Divider(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Server'),
                  Consumer(builder: (context, ref, child) {
                    final status =
                        ref.watch(websocketDetailsProvider.select((value) => value.status));

                    if (status == EyeConnectionStatus.disconnected) {
                      return const Text('Not yet connected');
                    } else if (status == EyeConnectionStatus.failed) {
                      return const Text('Failed, try restarting app.');
                    }
                    return const Text('Connected');
                  }),
                ],
              ),
              const Gap(8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bluetooth'),
                  Consumer(builder: (context, ref, child) {
                    final connection = ref.watch(bluetoothConnectionProvider);

                    return connection.when(
                        loading: () => const Text('Loading...'),
                        error: (_, __) => const Text('An error occurred.'),
                        data: (data) {
                          final connectedDevice = ref.watch(connectedDeviceProvider);
                          if (data == null || connectedDevice == null) {
                            return const Text('Not Yet Connected');
                          }

                          final deviceName = connectedDevice.name ?? connectedDevice.address;
                          return Text('Connected ($deviceName)');
                        });
                  }),
                ],
              ),
              const Gap(8),
              Wrap(
                children: [
                  Consumer(builder: (context, ref, _) {
                    return ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: ConnectServerSheet(
                                confirmCallback: (server) {
                                  ref.read(websocketDetailsProvider.notifier).connect(server);
                                  Navigator.of(context).pop();
                                },
                                backCallback: () => Navigator.of(context).pop(),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Server Connect'),
                    );
                  }),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DeviceDiscoveryPage(),
                      ),
                    ),
                    child: const Text('Initiate Connection'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(8),
        Consumer(builder: (context, ref, _) {
          return Card(
            child: PaddedColumn(
              padding: const EdgeInsets.all(16),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manual Controls',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Divider(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Card(
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'A-U',
                              ),
                            ),
                          ),
                          onTap: () => ref.read(sendSerialMessageProvider('7')),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'FWD',
                              ),
                            ),
                          ),
                          onTap: () => ref.read(sendSerialMessageProvider('1')),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'A-D',
                              ),
                            ),
                          ),
                          onTap: () => ref.read(sendSerialMessageProvider('6')),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Card(
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'L',
                              ),
                            ),
                          ),
                          onTap: () => ref.read(sendSerialMessageProvider('3')),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'REV',
                              ),
                            ),
                          ),
                          onTap: () => ref.read(sendSerialMessageProvider('2')),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'R',
                              ),
                            ),
                          ),
                          onTap: () => ref.read(sendSerialMessageProvider('4')),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.red,
                        child: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'STOP',
                              ),
                            ),
                          ),
                          onTap: () => ref.read(sendSerialMessageProvider('0')),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   children: [
                //     Expanded(
                //       child: Card(
                //         color: Colors.red,
                //         child: InkWell(
                //           child: const Padding(
                //             padding: EdgeInsets.all(16),
                //             child: Align(
                //               alignment: Alignment.center,
                //               child: Text(
                //                 'EXTINGUISH',
                //               ),
                //             ),
                //           ),
                //           onTap: () {
                //             ref.read(sendSerialMessageProvider('9'));
                //           },
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        }),
        const Gap(8),
        Card(
          child: PaddedColumn(
            padding: const EdgeInsets.all(16),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serial Messages',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Divider(),
              TextField(
                controller: _textEditingController,
                readOnly: true,
                minLines: 1,
                maxLines: 15,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firefighter'),
      ),
      body: SingleChildScrollView(
        child: _loading ? loadingScreen() : mainScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _textEditingController.clear(),
        child: const Icon(Icons.delete),
      ),
    );
  }
}
