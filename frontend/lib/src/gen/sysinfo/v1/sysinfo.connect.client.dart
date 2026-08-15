//
//  Generated code. Do not modify.
//  source: sysinfo/v1/sysinfo.proto
//

import "package:connectrpc/connect.dart" as connect;
import "sysinfo.pb.dart" as sysinfov1sysinfo;
import "sysinfo.connect.spec.dart" as specs;

extension type SysInfoServiceClient(connect.Transport _transport) {
  Future<sysinfov1sysinfo.GetSystemInfoResponse> getSystemInfo(
    sysinfov1sysinfo.GetSystemInfoRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SysInfoService.getSystemInfo,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Stream<sysinfov1sysinfo.WatchMetricsResponse> watchMetrics(
    sysinfov1sysinfo.WatchMetricsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).server(
      specs.SysInfoService.watchMetrics,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
