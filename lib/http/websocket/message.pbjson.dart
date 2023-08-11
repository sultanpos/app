//
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use welcomeDescriptor instead')
const Welcome$json = {
  '1': 'Welcome',
};

/// Descriptor for `Welcome`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List welcomeDescriptor = $convert.base64Decode(
    'CgdXZWxjb21l');

@$core.Deprecated('Use recordUpdatedDescriptor instead')
const RecordUpdated$json = {
  '1': 'RecordUpdated',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'ids', '3': 2, '4': 3, '5': 3, '10': 'ids'},
  ],
};

/// Descriptor for `RecordUpdated`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordUpdatedDescriptor = $convert.base64Decode(
    'Cg1SZWNvcmRVcGRhdGVkEhIKBG5hbWUYASABKAlSBG5hbWUSEAoDaWRzGAIgAygDUgNpZHM=');

@$core.Deprecated('Use recordDeletedDescriptor instead')
const RecordDeleted$json = {
  '1': 'RecordDeleted',
  '2': [
    {'1': 'ids', '3': 1, '4': 3, '5': 3, '10': 'ids'},
  ],
};

/// Descriptor for `RecordDeleted`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordDeletedDescriptor = $convert.base64Decode(
    'Cg1SZWNvcmREZWxldGVkEhAKA2lkcxgBIAMoA1IDaWRz');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 3, '10': 'timestamp'},
    {'1': 'welcome', '3': 100, '4': 1, '5': 11, '6': '.message.Welcome', '9': 0, '10': 'welcome'},
    {'1': 'recordUpdated', '3': 101, '4': 1, '5': 11, '6': '.message.RecordUpdated', '9': 0, '10': 'recordUpdated'},
    {'1': 'recordDeleted', '3': 102, '4': 1, '5': 11, '6': '.message.RecordDeleted', '9': 0, '10': 'recordDeleted'},
  ],
  '8': [
    {'1': 'message'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEhwKCXRpbWVzdGFtcBgBIAEoA1IJdGltZXN0YW1wEiwKB3dlbGNvbWUYZCABKA'
    'syEC5tZXNzYWdlLldlbGNvbWVIAFIHd2VsY29tZRI+Cg1yZWNvcmRVcGRhdGVkGGUgASgLMhYu'
    'bWVzc2FnZS5SZWNvcmRVcGRhdGVkSABSDXJlY29yZFVwZGF0ZWQSPgoNcmVjb3JkRGVsZXRlZB'
    'hmIAEoCzIWLm1lc3NhZ2UuUmVjb3JkRGVsZXRlZEgAUg1yZWNvcmREZWxldGVkQgkKB21lc3Nh'
    'Z2U=');

