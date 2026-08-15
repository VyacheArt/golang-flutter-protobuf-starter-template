// This is a generated file - do not edit.
//
// Generated from sysinfo/v1/sysinfo.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getSystemInfoRequestDescriptor instead')
const GetSystemInfoRequest$json = {
  '1': 'GetSystemInfoRequest',
};

/// Descriptor for `GetSystemInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSystemInfoRequestDescriptor =
    $convert.base64Decode('ChRHZXRTeXN0ZW1JbmZvUmVxdWVzdA==');

@$core.Deprecated('Use getSystemInfoResponseDescriptor instead')
const GetSystemInfoResponse$json = {
  '1': 'GetSystemInfoResponse',
  '2': [
    {'1': 'hostname', '3': 1, '4': 1, '5': 9, '10': 'hostname'},
    {'1': 'go_version', '3': 2, '4': 1, '5': 9, '10': 'goVersion'},
    {'1': 'os', '3': 3, '4': 1, '5': 9, '10': 'os'},
  ],
};

/// Descriptor for `GetSystemInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSystemInfoResponseDescriptor = $convert.base64Decode(
    'ChVHZXRTeXN0ZW1JbmZvUmVzcG9uc2USGgoIaG9zdG5hbWUYASABKAlSCGhvc3RuYW1lEh0KCm'
    'dvX3ZlcnNpb24YAiABKAlSCWdvVmVyc2lvbhIOCgJvcxgDIAEoCVICb3M=');

@$core.Deprecated('Use watchMetricsRequestDescriptor instead')
const WatchMetricsRequest$json = {
  '1': 'WatchMetricsRequest',
};

/// Descriptor for `WatchMetricsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchMetricsRequestDescriptor =
    $convert.base64Decode('ChNXYXRjaE1ldHJpY3NSZXF1ZXN0');

@$core.Deprecated('Use watchMetricsResponseDescriptor instead')
const WatchMetricsResponse$json = {
  '1': 'WatchMetricsResponse',
  '2': [
    {'1': 'allocated_memory', '3': 1, '4': 1, '5': 4, '10': 'allocatedMemory'},
    {'1': 'num_goroutines', '3': 2, '4': 1, '5': 4, '10': 'numGoroutines'},
  ],
};

/// Descriptor for `WatchMetricsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watchMetricsResponseDescriptor = $convert.base64Decode(
    'ChRXYXRjaE1ldHJpY3NSZXNwb25zZRIpChBhbGxvY2F0ZWRfbWVtb3J5GAEgASgEUg9hbGxvY2'
    'F0ZWRNZW1vcnkSJQoObnVtX2dvcm91dGluZXMYAiABKARSDW51bUdvcm91dGluZXM=');

const $core.Map<$core.String, $core.dynamic> SysInfoServiceBase$json = {
  '1': 'SysInfoService',
  '2': [
    {
      '1': 'GetSystemInfo',
      '2': '.sysinfo.v1.GetSystemInfoRequest',
      '3': '.sysinfo.v1.GetSystemInfoResponse',
      '4': {}
    },
    {
      '1': 'WatchMetrics',
      '2': '.sysinfo.v1.WatchMetricsRequest',
      '3': '.sysinfo.v1.WatchMetricsResponse',
      '4': {},
      '6': true
    },
  ],
};

@$core.Deprecated('Use sysInfoServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    SysInfoServiceBase$messageJson = {
  '.sysinfo.v1.GetSystemInfoRequest': GetSystemInfoRequest$json,
  '.sysinfo.v1.GetSystemInfoResponse': GetSystemInfoResponse$json,
  '.sysinfo.v1.WatchMetricsRequest': WatchMetricsRequest$json,
  '.sysinfo.v1.WatchMetricsResponse': WatchMetricsResponse$json,
};

/// Descriptor for `SysInfoService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List sysInfoServiceDescriptor = $convert.base64Decode(
    'Cg5TeXNJbmZvU2VydmljZRJWCg1HZXRTeXN0ZW1JbmZvEiAuc3lzaW5mby52MS5HZXRTeXN0ZW'
    '1JbmZvUmVxdWVzdBohLnN5c2luZm8udjEuR2V0U3lzdGVtSW5mb1Jlc3BvbnNlIgASVQoMV2F0'
    'Y2hNZXRyaWNzEh8uc3lzaW5mby52MS5XYXRjaE1ldHJpY3NSZXF1ZXN0GiAuc3lzaW5mby52MS'
    '5XYXRjaE1ldHJpY3NSZXNwb25zZSIAMAE=');
