import 'package:connectrpc/connect.dart';

Transport getTransport(String socketOrAddr, {bool isUds = true}) =>
    throw UnsupportedError('Cannot create a transport on this platform.');
