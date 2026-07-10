//
//  Generated code. Do not modify.
//  source: sysinfo/v1/sysinfo.proto
//

import "package:connectrpc/connect.dart" as connect;
import "sysinfo.pb.dart" as sysinfov1sysinfo;

abstract final class SysInfoService {
  /// Fully-qualified name of the SysInfoService service.
  static const name = 'sysinfo.v1.SysInfoService';

  static const getSystemInfo = connect.Spec(
    '/$name/GetSystemInfo',
    connect.StreamType.unary,
    sysinfov1sysinfo.GetSystemInfoRequest.new,
    sysinfov1sysinfo.GetSystemInfoResponse.new,
  );

  static const watchMetrics = connect.Spec(
    '/$name/WatchMetrics',
    connect.StreamType.server,
    sysinfov1sysinfo.WatchMetricsRequest.new,
    sysinfov1sysinfo.WatchMetricsResponse.new,
  );
}
