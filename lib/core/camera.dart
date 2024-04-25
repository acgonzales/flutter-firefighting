import 'package:camera/camera.dart' as cam;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera.g.dart';

@riverpod
Future<List<cam.CameraDescription>> availableCameras(AvailableCamerasRef ref) {
  return cam.availableCameras();
}
