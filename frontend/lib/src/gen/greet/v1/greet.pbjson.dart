// This is a generated file - do not edit.
//
// Generated from greet/v1/greet.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use greetRequestDescriptor instead')
const GreetRequest$json = {
  '1': 'GreetRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GreetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List greetRequestDescriptor =
    $convert.base64Decode('CgxHcmVldFJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use greetResponseDescriptor instead')
const GreetResponse$json = {
  '1': 'GreetResponse',
  '2': [
    {'1': 'greeting', '3': 2, '4': 1, '5': 9, '10': 'greeting'},
  ],
};

/// Descriptor for `GreetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List greetResponseDescriptor = $convert.base64Decode(
    'Cg1HcmVldFJlc3BvbnNlEhoKCGdyZWV0aW5nGAIgASgJUghncmVldGluZw==');

const $core.Map<$core.String, $core.dynamic> GreetServiceBase$json = {
  '1': 'GreetService',
  '2': [
    {
      '1': 'Greet',
      '2': '.greet.v1.GreetRequest',
      '3': '.greet.v1.GreetResponse',
      '4': {}
    },
  ],
};

@$core.Deprecated('Use greetServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    GreetServiceBase$messageJson = {
  '.greet.v1.GreetRequest': GreetRequest$json,
  '.greet.v1.GreetResponse': GreetResponse$json,
};

/// Descriptor for `GreetService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List greetServiceDescriptor = $convert.base64Decode(
    'CgxHcmVldFNlcnZpY2USOgoFR3JlZXQSFi5ncmVldC52MS5HcmVldFJlcXVlc3QaFy5ncmVldC'
    '52MS5HcmVldFJlc3BvbnNlIgA=');
