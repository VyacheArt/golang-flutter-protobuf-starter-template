// This is a generated file - do not edit.
//
// Generated from greet/v1/greet.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'greet.pb.dart' as $0;
import 'greet.pbjson.dart';

export 'greet.pb.dart';

abstract class GreetServiceBase extends $pb.GeneratedService {
  $async.Future<$0.GreetResponse> greet(
      $pb.ServerContext ctx, $0.GreetRequest request);
  $async.Future<$0.GreetResponse> greetStream(
      $pb.ServerContext ctx, $0.GreetRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Greet':
        return $0.GreetRequest();
      case 'GreetStream':
        return $0.GreetRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Greet':
        return greet(ctx, request as $0.GreetRequest);
      case 'GreetStream':
        return greetStream(ctx, request as $0.GreetRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => GreetServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => GreetServiceBase$messageJson;
}
