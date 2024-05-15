// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pairedDevicesHash() => r'8681529f9548caed3a0f3047676c45f35f216b4b';

/// See also [pairedDevices].
@ProviderFor(pairedDevices)
final pairedDevicesProvider =
    AutoDisposeFutureProvider<List<BluetoothDevice>>.internal(
  pairedDevices,
  name: r'pairedDevicesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pairedDevicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PairedDevicesRef = AutoDisposeFutureProviderRef<List<BluetoothDevice>>;
String _$bluetoothConnectionHash() =>
    r'e105cd056acfe96673dae53dc545765d4595e7c2';

/// See also [bluetoothConnection].
@ProviderFor(bluetoothConnection)
final bluetoothConnectionProvider =
    AutoDisposeFutureProvider<BluetoothConnection?>.internal(
  bluetoothConnection,
  name: r'bluetoothConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bluetoothConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BluetoothConnectionRef
    = AutoDisposeFutureProviderRef<BluetoothConnection?>;
String _$sendSerialMessageHash() => r'50d0c0c7d7c0a65a9f227da89e08f1202c79e995';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [sendSerialMessage].
@ProviderFor(sendSerialMessage)
const sendSerialMessageProvider = SendSerialMessageFamily();

/// See also [sendSerialMessage].
class SendSerialMessageFamily extends Family<AsyncValue<void>> {
  /// See also [sendSerialMessage].
  const SendSerialMessageFamily();

  /// See also [sendSerialMessage].
  SendSerialMessageProvider call(
    String message,
  ) {
    return SendSerialMessageProvider(
      message,
    );
  }

  @override
  SendSerialMessageProvider getProviderOverride(
    covariant SendSerialMessageProvider provider,
  ) {
    return call(
      provider.message,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sendSerialMessageProvider';
}

/// See also [sendSerialMessage].
class SendSerialMessageProvider extends AutoDisposeFutureProvider<void> {
  /// See also [sendSerialMessage].
  SendSerialMessageProvider(
    String message,
  ) : this._internal(
          (ref) => sendSerialMessage(
            ref as SendSerialMessageRef,
            message,
          ),
          from: sendSerialMessageProvider,
          name: r'sendSerialMessageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendSerialMessageHash,
          dependencies: SendSerialMessageFamily._dependencies,
          allTransitiveDependencies:
              SendSerialMessageFamily._allTransitiveDependencies,
          message: message,
        );

  SendSerialMessageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.message,
  }) : super.internal();

  final String message;

  @override
  Override overrideWith(
    FutureOr<void> Function(SendSerialMessageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendSerialMessageProvider._internal(
        (ref) => create(ref as SendSerialMessageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        message: message,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SendSerialMessageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendSerialMessageProvider && other.message == message;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, message.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SendSerialMessageRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `message` of this provider.
  String get message;
}

class _SendSerialMessageProviderElement
    extends AutoDisposeFutureProviderElement<void> with SendSerialMessageRef {
  _SendSerialMessageProviderElement(super.provider);

  @override
  String get message => (origin as SendSerialMessageProvider).message;
}

String _$connectedDeviceHash() => r'1b928e2b8f83fd60fa2c2e74104886488f3c9ad7';

/// See also [ConnectedDevice].
@ProviderFor(ConnectedDevice)
final connectedDeviceProvider =
    AutoDisposeNotifierProvider<ConnectedDevice, BluetoothDevice?>.internal(
  ConnectedDevice.new,
  name: r'connectedDeviceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectedDeviceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConnectedDevice = AutoDisposeNotifier<BluetoothDevice?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
