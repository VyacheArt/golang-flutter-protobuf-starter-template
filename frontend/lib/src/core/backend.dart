import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:connectrpc/connect.dart';
import '../ffi/backend_runner.dart';
import '../rpc/transport_stub.dart'
    if (dart.library.io) '../rpc/transport_io.dart'
    as rpc;

class Backend {
  final Transport transport;
  final BackendRunner? _runner;

  Backend(this.transport, [this._runner]);

  /// Initializes the backend, spawning the Go shared library via FFI.
  /// This abstracts away the socket creation and FFI bindings from the main app.
  static Future<Backend> init() async {
    const useTcpEnv = String.fromEnvironment('APP_USE_TCP', defaultValue: '');
    final useTcp = useTcpEnv == 'true' || Platform.environment['APP_USE_TCP'] == 'true';
    
    const tcpAddressEnv = String.fromEnvironment('APP_TCP_ADDRESS', defaultValue: '');
    final tcpAddress = tcpAddressEnv.isNotEmpty 
        ? tcpAddressEnv 
        : (Platform.environment['APP_TCP_ADDRESS'] ?? '127.0.0.1:8080');

    final runner = BackendRunner();

    if (useTcp) {
      try {
        runner.startTcp(tcpAddress);
        debugPrint('[Frontend] FFI Backend started natively on TCP: $tcpAddress');
      } catch (e) {
        debugPrint('[Frontend] Could not start FFI TCP backend, assuming it is running externally: $e');
      }

      debugPrint('[Frontend] Configuring transport for TCP: $tcpAddress');
      final transport = rpc.getTransport(tcpAddress, isUds: false);
      return Backend(transport, runner);
    } else {
      final socketPath = '${Directory.systemTemp.path}/app_backend_$pid.sock';
      try {
        runner.startUds(socketPath);
        debugPrint('[Frontend] FFI Backend started natively on UDS: $socketPath');
      } catch (e) {
        debugPrint('[Frontend] Could not start FFI UDS backend, assuming it is running externally: $e');
      }

      debugPrint('[Frontend] Configuring transport for UDS: $socketPath');
      final transport = rpc.getTransport(socketPath, isUds: true);
      return Backend(transport, runner);
    }
  }

  void dispose() {
    try {
      debugPrint('[Frontend] Disposing FFI Backend...');
      _runner?.stop();
    } catch (e) {
      debugPrint('[Frontend] Error stopping backend: $e');
    }
  }
}
