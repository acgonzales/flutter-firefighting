import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detect_model.g.dart';

@riverpod
Future<String?> loadModel(LoadModelRef ref) {
  Tflite.close();
  return Tflite.loadModel(
    model: 'assets/model_unquant.tflite',
    labels: 'assets/labels.txt',
  );
}
