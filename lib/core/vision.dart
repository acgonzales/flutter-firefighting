// import 'package:flutter_vision/flutter_vision.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'vision.g.dart';

// @riverpod
// Future<FlutterVision> objectModel(ObjectModelRef ref) async {
//   final vision = FlutterVision();
//   await vision.loadYoloModel(
//     modelPath: 'assets/yolov5.tflite',
//     labels: 'assets/test_labels.txt',
//     modelVersion: 'yolov5',
//     quantization: true,
//   );

//   ref.onDispose(() async {
//     await vision.closeYoloModel();
//   });

//   return vision;
// }
