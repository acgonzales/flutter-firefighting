import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_firefighter/core/bluetooth.dart';
import 'package:flutter_firefighter/core/camera.dart';
import 'package:flutter_firefighter/core/detect_model.dart';
import 'package:flutter_firefighter/pages/device_discovery_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  bool _loading = true;

  late ByteData testImage;
  List<Map<String, dynamic>> result = [];

  late TextEditingController _textEditingController;

  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();

    ref.read(availableCamerasProvider.future).then((cameras) => {
          _cameraController = CameraController(
            cameras[0],
            ResolutionPreset.high,
            enableAudio: false,
          ),
          _cameraController.initialize().then((_) {
            if (!mounted) return;
            setState(() {});
          })
        });

    ref.read(loadModelProvider.future).then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  Widget loadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget mainScreen() {
    return PaddedColumn(
      padding: const EdgeInsets.all(16),
      children: [
        _cameraController.value.isInitialized
            ? Card(
                child: SizedBox(
                  width: double.infinity,
                  height: 180.0,
                  child: Center(
                    child: CameraPreview(
                      _cameraController,
                    ),
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
                'Configuration',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Divider(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bluetooth'),
                  Consumer(
                      child: const Text('Loading...'),
                      builder: (context, ref, child) {
                        final bluetoothAsyncValue = ref.watch(bluetoothNotifierProvider);
                        return bluetoothAsyncValue.when(
                          data: (data) => Text(
                              '${toBeginningOfSentenceCase(data.status.name)} (${data.connectedDevice?.name ?? 'Not yet connected'})'),
                          error: (error, st) => const Text('Error occurred'),
                          loading: () => child!,
                        );
                      }),
                ],
              ),
              const Gap(8),
              Consumer(
                child: const SizedBox.shrink(),
                builder: (context, ref, child) {
                  final bluetoothAsyncValue = ref.watch(bluetoothNotifierProvider);
                  return bluetoothAsyncValue.when(
                      data: (data) => Wrap(
                            children: [
                              data.status == BluetoothStatus.disabled
                                  ? ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(bluetoothNotifierProvider.notifier)
                                            .requestPermissions();
                                      },
                                      child: const Text('Give Bluetooth Permission'))
                                  : child!,
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
                      error: (error, st) => const Text('An error occurred.'),
                      loading: () => child!);
                },
              )
            ],
          ),
        ),
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

  Future recognizeImage(String path) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: path,
      numResults: 3,
      threshold: 0.9,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
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
        onPressed: () async {
          _textEditingController.text = "Hello\n";
          // FilePickerResult result = (await FilePicker.platform.pickFiles(type: FileType.image))!;
          // recognizeImage(result.files.single.path!);
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
