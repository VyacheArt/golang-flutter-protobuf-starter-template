// This is a generated file - do not edit.
//
// Generated from greet/v1/greet.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GreetRequest extends $pb.GeneratedMessage {
  factory GreetRequest({
    $core.String? name,
  }) {
    final result = create();
    if (name != null) result.name = name;
    return result;
  }

  GreetRequest._();

  factory GreetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GreetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GreetRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'greet.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GreetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GreetRequest copyWith(void Function(GreetRequest) updates) =>
      super.copyWith((message) => updates(message as GreetRequest))
          as GreetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GreetRequest create() => GreetRequest._();
  @$core.override
  GreetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GreetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GreetRequest>(create);
  static GreetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
}

class GreetResponse extends $pb.GeneratedMessage {
  factory GreetResponse({
    $core.String? greeting,
  }) {
    final result = create();
    if (greeting != null) result.greeting = greeting;
    return result;
  }

  GreetResponse._();

  factory GreetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GreetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GreetResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'greet.v1'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'greeting')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GreetResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GreetResponse copyWith(void Function(GreetResponse) updates) =>
      super.copyWith((message) => updates(message as GreetResponse))
          as GreetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GreetResponse create() => GreetResponse._();
  @$core.override
  GreetResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GreetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GreetResponse>(create);
  static GreetResponse? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get greeting => $_getSZ(0);
  @$pb.TagNumber(2)
  set greeting($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasGreeting() => $_has(0);
  @$pb.TagNumber(2)
  void clearGreeting() => $_clearField(2);
}

class GreetServiceApi {
  final $pb.RpcClient _client;

  GreetServiceApi(this._client);

  $async.Future<GreetResponse> greet(
          $pb.ClientContext? ctx, GreetRequest request) =>
      _client.invoke<GreetResponse>(
          ctx, 'GreetService', 'Greet', request, GreetResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
