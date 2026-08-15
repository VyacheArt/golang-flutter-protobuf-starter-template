// This is a generated file - do not edit.
//
// Generated from sysinfo/v1/sysinfo.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'sysinfo.pb.dart' as $0;
import 'sysinfo.pbjson.dart';

export 'sysinfo.pb.dart';

abstract class SysInfoServiceBase extends $pb.GeneratedService {
  $async.Future<$0.GetSystemInfoResponse> getSystemInfo(
      $pb.ServerContext ctx, $0.GetSystemInfoRequest request);
  $async.Future<$0.WatchMetricsResponse> watchMetrics(
      $pb.ServerContext ctx, $0.WatchMetricsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetSystemInfo':
        return $0.GetSystemInfoRequest();
      case 'WatchMetrics':
        return $0.WatchMetricsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetSystemInfo':
        return getSystemInfo(ctx, request as $0.GetSystemInfoRequest);
      case 'WatchMetrics':
        return watchMetrics(ctx, request as $0.WatchMetricsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => SysInfoServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => SysInfoServiceBase$messageJson;
}
