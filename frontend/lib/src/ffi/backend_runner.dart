import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef StartUDSServerC = Pointer<Utf8> Function(Pointer<Utf8> socketPath);
typedef StartUDSServerDart = Pointer<Utf8> Function(Pointer<Utf8> socketPath);

typedef StartTCPServerC = Pointer<Utf8> Function(Pointer<Utf8> address);
typedef StartTCPServerDart = Pointer<Utf8> Function(Pointer<Utf8> address);

typedef StopServerC = Pointer<Utf8> Function();
typedef StopServerDart = Pointer<Utf8> Function();

/// BackendRunner manages the lifecycle of the Go FFI shared library.
/// It loads the library on initialization and provides methods to start/stop the UDS and TCP servers.
class BackendRunner {
  late final DynamicLibrary _lib;
  late final StartUDSServerDart _startUds;
  late final StartTCPServerDart _startTcp;
  late final StopServerDart _stopServer;

  BackendRunner() {
    String libName;
    if (Platform.isLinux) {
      libName = 'libbackend.so';
    } else if (Platform.isMacOS) {
      libName = 'libbackend.dylib';
    } else if (Platform.isWindows) {
      libName = 'libbackend.dll';
    } else {
      throw UnsupportedError('Unsupported platform for FFI');
    }

    _lib = _openLibrary(libName);
    _startUds = _lib.lookupFunction<StartUDSServerC, StartUDSServerDart>('StartUDSServer');
    _startTcp = _lib.lookupFunction<StartTCPServerC, StartTCPServerDart>('StartTCPServer');
    _stopServer = _lib.lookupFunction<StopServerC, StopServerDart>('StopServer');
  }

  DynamicLibrary _openLibrary(String name) {
    try {
      // Tries to load from system paths (or Android standard library path)
      return DynamicLibrary.open(name);
    } catch (_) {
      // Fallback 1: Production bundle on Linux/Windows (lib/ directory next to executable)
      final exeDir = File(Platform.resolvedExecutable).parent.path;
      final bundledPath = '$exeDir/lib/$name';
      if (File(bundledPath).existsSync()) {
        return DynamicLibrary.open(bundledPath);
      }

      // Fallback 2: Local development via `flutter run` from project root
      final platformDir = Platform.isLinux ? 'linux' : Platform.isMacOS ? 'macos' : 'windows';
      final devPath = '${Directory.current.path}/$platformDir/$name';
      if (File(devPath).existsSync()) {
        return DynamicLibrary.open(devPath);
      }

      rethrow;
    }
  }

  void startUds(String socketPath) {
    final pathPtr = socketPath.toNativeUtf8();
    final errPtr = _startUds(pathPtr);
    calloc.free(pathPtr);
    if (errPtr != nullptr) {
      final err = errPtr.toDartString();
      calloc.free(errPtr);
      throw Exception('Failed to start UDS server: $err');
    }
  }

  void startTcp(String address) {
    final addrPtr = address.toNativeUtf8();
    final errPtr = _startTcp(addrPtr);
    calloc.free(addrPtr);
    if (errPtr != nullptr) {
      final err = errPtr.toDartString();
      calloc.free(errPtr);
      throw Exception('Failed to start TCP server: $err');
    }
  }

  void stop() {
    final errPtr = _stopServer();
    if (errPtr != nullptr) {
      final err = errPtr.toDartString();
      calloc.free(errPtr);
      throw Exception('Failed to stop server: $err');
    }
  }
}
