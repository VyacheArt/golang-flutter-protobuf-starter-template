// This is a generated file - do not edit.
//
// Generated from sysinfo/v1/sysinfo.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetSystemInfoRequest extends $pb.GeneratedMessage {
  factory GetSystemInfoRequest() => create();

  GetSystemInfoRequest._();

  factory GetSystemInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSystemInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSystemInfoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sysinfo.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSystemInfoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSystemInfoRequest copyWith(void Function(GetSystemInfoRequest) updates) =>
      super.copyWith((message) => updates(message as GetSystemInfoRequest))
          as GetSystemInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSystemInfoRequest create() => GetSystemInfoRequest._();
  @$core.override
  GetSystemInfoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSystemInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSystemInfoRequest>(create);
  static GetSystemInfoRequest? _defaultInstance;
}

class GetSystemInfoResponse extends $pb.GeneratedMessage {
  factory GetSystemInfoResponse({
    $core.String? hostname,
    $core.String? goVersion,
    $core.String? os,
  }) {
    final result = create();
    if (hostname != null) result.hostname = hostname;
    if (goVersion != null) result.goVersion = goVersion;
    if (os != null) result.os = os;
    return result;
  }

  GetSystemInfoResponse._();

  factory GetSystemInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSystemInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSystemInfoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sysinfo.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hostname')
    ..aOS(2, _omitFieldNames ? '' : 'goVersion')
    ..aOS(3, _omitFieldNames ? '' : 'os')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSystemInfoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSystemInfoResponse copyWith(
          void Function(GetSystemInfoResponse) updates) =>
      super.copyWith((message) => updates(message as GetSystemInfoResponse))
          as GetSystemInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSystemInfoResponse create() => GetSystemInfoResponse._();
  @$core.override
  GetSystemInfoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSystemInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSystemInfoResponse>(create);
  static GetSystemInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hostname => $_getSZ(0);
  @$pb.TagNumber(1)
  set hostname($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHostname() => $_has(0);
  @$pb.TagNumber(1)
  void clearHostname() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get goVersion => $_getSZ(1);
  @$pb.TagNumber(2)
  set goVersion($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGoVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearGoVersion() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get os => $_getSZ(2);
  @$pb.TagNumber(3)
  set os($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOs() => $_has(2);
  @$pb.TagNumber(3)
  void clearOs() => $_clearField(3);
}

class WatchMetricsRequest extends $pb.GeneratedMessage {
  factory WatchMetricsRequest() => create();

  WatchMetricsRequest._();

  factory WatchMetricsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WatchMetricsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WatchMetricsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sysinfo.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchMetricsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchMetricsRequest copyWith(void Function(WatchMetricsRequest) updates) =>
      super.copyWith((message) => updates(message as WatchMetricsRequest))
          as WatchMetricsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchMetricsRequest create() => WatchMetricsRequest._();
  @$core.override
  WatchMetricsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WatchMetricsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WatchMetricsRequest>(create);
  static WatchMetricsRequest? _defaultInstance;
}

class WatchMetricsResponse extends $pb.GeneratedMessage {
  factory WatchMetricsResponse({
    $fixnum.Int64? allocatedMemory,
    $fixnum.Int64? numGoroutines,
  }) {
    final result = create();
    if (allocatedMemory != null) result.allocatedMemory = allocatedMemory;
    if (numGoroutines != null) result.numGoroutines = numGoroutines;
    return result;
  }

  WatchMetricsResponse._();

  factory WatchMetricsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WatchMetricsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WatchMetricsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sysinfo.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'allocatedMemory', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'numGoroutines', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchMetricsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchMetricsResponse copyWith(void Function(WatchMetricsResponse) updates) =>
      super.copyWith((message) => updates(message as WatchMetricsResponse))
          as WatchMetricsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchMetricsResponse create() => WatchMetricsResponse._();
  @$core.override
  WatchMetricsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WatchMetricsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WatchMetricsResponse>(create);
  static WatchMetricsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get allocatedMemory => $_getI64(0);
  @$pb.TagNumber(1)
  set allocatedMemory($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAllocatedMemory() => $_has(0);
  @$pb.TagNumber(1)
  void clearAllocatedMemory() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get numGoroutines => $_getI64(1);
  @$pb.TagNumber(2)
  set numGoroutines($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNumGoroutines() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumGoroutines() => $_clearField(2);
}

class SysInfoServiceApi {
  final $pb.RpcClient _client;

  SysInfoServiceApi(this._client);

  $async.Future<GetSystemInfoResponse> getSystemInfo(
          $pb.ClientContext? ctx, GetSystemInfoRequest request) =>
      _client.invoke<GetSystemInfoResponse>(ctx, 'SysInfoService',
          'GetSystemInfo', request, GetSystemInfoResponse());
  $async.Future<WatchMetricsResponse> watchMetrics(
          $pb.ClientContext? ctx, WatchMetricsRequest request) =>
      _client.invoke<WatchMetricsResponse>(ctx, 'SysInfoService',
          'WatchMetrics', request, WatchMetricsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
