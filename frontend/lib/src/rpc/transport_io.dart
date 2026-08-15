import 'dart:io' as io;
import 'package:connectrpc/connect.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/connect.dart' as protocol;
import 'package:connectrpc/http2.dart' as connect_http2;
import 'package:http2/http2.dart' as http2;

/// An HTTP/2 connection over a Unix Domain Socket.
///
/// The default [connect_http2.Http2ClientTransport] only dials TCP, so this
/// minimal implementation opens the UDS itself and reuses a single connection.
class _UdsHttp2Transport implements connect_http2.Http2ClientTransport {
  final String socketPath;
  http2.ClientTransportConnection? _connection;

  _UdsHttp2Transport(this.socketPath);

  @override
  Future<http2.ClientTransportStream> makeRequest(
    Uri uri,
    List<http2.Header> headers,
  ) async {
    var connection = _connection;
    if (connection == null || !connection.isOpen) {
      final socket = await io.Socket.connect(
        io.InternetAddress(socketPath, type: io.InternetAddressType.unix),
        0,
      );
      connection = http2.ClientTransportConnection.viaSocket(socket);
      _connection = connection;
    }
    return connection.makeRequest(headers);
  }
}

Transport getTransport(String address, {bool isUds = true}) {
  // HTTP/2 (h2c) end-to-end: the Go server enables unencrypted HTTP/2, and
  // full-duplex bidirectional streaming only works over HTTP/2 — dart:io's
  // HttpClient is HTTP/1.1 and cannot carry it.
  return protocol.Transport(
    // For UDS the socket routes the connection, so the host part is unused.
    baseUrl: "http://${isUds ? 'localhost' : address}",
    codec: const ProtoCodec(),
    httpClient: isUds
        ? connect_http2.createHttpClient(transport: _UdsHttp2Transport(address))
        : connect_http2.createHttpClient(),
  );
}
