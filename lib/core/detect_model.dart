// import 'package:camera/camera.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'detect_model.g.dart';
// part 'detect_model.freezed.dart';

// @freezed
// class Detection with _$Detection {
//   factory Detection({
//     required String label,
//     required double confidence,
//     required int x,
//     required int y,
//     required int w,
//     required int h,
//     required String section,
//   }) = _Detection;

//   const Detection._();
// }

// @riverpod
// Future<String?> loadModel(LoadModelRef ref) {
//   Tflite.close();
//   return Tflite.loadModel(
//     model: 'assets/model_unquant.tflite',
//     labels: 'assets/labels.txt',
//   );
// }

// @riverpod
// Future<List<Detection>> detect(DetectRef ref, CameraImage image) async {
//   await ref.read(loadModelProvider.future);

//   final recognitions = await Tflite.detectObjectOnFrame(
//       bytesList: image.planes.map((plane) {
//         return plane.bytes;
//       }).toList(),
//       imageHeight: image.height,
//       imageWidth: image.width,
//       imageMean: 127.5,
//       imageStd: 127.5,
//       numResultsPerClass: 1,
//       threshold: 0.99,
//       asynch: true);

//   if (recognitions != null && recognitions.isNotEmpty) {
//     return recognitions
//         .map(
//           (e) => Detection(
//             label: e['detectedClass'] ?? 'Unknown',
//             confidence: e['confidenceInClass'],
//             x: e['rect']['x'],
//             y: e['rect']['y'],
//             w: e['rect']['w'],
//             h: e['rect']['h'],
//             section: 'Unknown', // edit this
//           ),
//         )
//         .toList();
//   }

//   return [];
// }

// @riverpod
// class DetectionsNotifier extends _$DetectionsNotifier {
//   @override
//   List<Detection> build() => [];

//   void setDetections(List<Detection> newDetections) {
//     state = newDetections;
//   }
// }

// @riverpod
// class IsDetecting extends _$IsDetecting {
//   @override
//   bool build() {
//     return false;
//   }

//   void setDetecting(bool detecting) {
//     state = detecting;
//   }
// }
