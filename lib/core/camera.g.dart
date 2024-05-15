// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$availableCamerasHash() => r'82f3d192ea6dd8894c775305d0f1dee8a9112574';

/// See also [availableCameras].
@ProviderFor(availableCameras)
final availableCamerasProvider =
    AutoDisposeFutureProvider<List<cam.CameraDescription>>.internal(
  availableCameras,
  name: r'availableCamerasProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableCamerasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AvailableCamerasRef
    = AutoDisposeFutureProviderRef<List<cam.CameraDescription>>;
String _$cameraBusyHash() => r'6c71f05a867d5bb4810eda8b079c55fc03c7e8db';

/// See also [CameraBusy].
@ProviderFor(CameraBusy)
final cameraBusyProvider =
    AutoDisposeNotifierProvider<CameraBusy, bool>.internal(
  CameraBusy.new,
  name: r'cameraBusyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cameraBusyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CameraBusy = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
