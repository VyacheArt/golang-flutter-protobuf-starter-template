import 'dart:io' as io;
import 'package:connectrpc/connect.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/connect.dart' as protocol;
import 'package:connectrpc/io.dart' as connect_io;

Transport getTransport(String address, {bool isUds = true}) {
  final ioClient = io.HttpClient();

  if (isUds) {
    ioClient.connectionFactory = (uri, proxyHost, proxyPort) {
      return io.Socket.startConnect(
        io.InternetAddress(address, type: io.InternetAddressType.unix),
        0,
      );
    };
    return protocol.Transport(
      baseUrl: "http://localhost", // Base URL doesn't matter much as the socket routes to UDS
      codec: const ProtoCodec(),
      httpClient: connect_io.createHttpClient(ioClient),
    );
  } else {
    // For TCP, we don't need a custom connectionFactory
    return protocol.Transport(
      baseUrl: "http://$address",
      codec: const ProtoCodec(),
      httpClient: connect_io.createHttpClient(ioClient),
    );
  }
}
