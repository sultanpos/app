//
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Welcome extends $pb.GeneratedMessage {
  factory Welcome() => create();
  Welcome._() : super();
  factory Welcome.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Welcome.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Welcome', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Welcome clone() => Welcome()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Welcome copyWith(void Function(Welcome) updates) => super.copyWith((message) => updates(message as Welcome)) as Welcome;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Welcome create() => Welcome._();
  Welcome createEmptyInstance() => create();
  static $pb.PbList<Welcome> createRepeated() => $pb.PbList<Welcome>();
  @$core.pragma('dart2js:noInline')
  static Welcome getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Welcome>(create);
  static Welcome? _defaultInstance;
}

class RecordUpdated extends $pb.GeneratedMessage {
  factory RecordUpdated() => create();
  RecordUpdated._() : super();
  factory RecordUpdated.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordUpdated.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecordUpdated', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'ids', $pb.PbFieldType.K6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordUpdated clone() => RecordUpdated()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordUpdated copyWith(void Function(RecordUpdated) updates) => super.copyWith((message) => updates(message as RecordUpdated)) as RecordUpdated;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordUpdated create() => RecordUpdated._();
  RecordUpdated createEmptyInstance() => create();
  static $pb.PbList<RecordUpdated> createRepeated() => $pb.PbList<RecordUpdated>();
  @$core.pragma('dart2js:noInline')
  static RecordUpdated getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordUpdated>(create);
  static RecordUpdated? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$fixnum.Int64> get ids => $_getList(1);
}

class RecordDeleted extends $pb.GeneratedMessage {
  factory RecordDeleted() => create();
  RecordDeleted._() : super();
  factory RecordDeleted.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordDeleted.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RecordDeleted', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'ids', $pb.PbFieldType.K6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordDeleted clone() => RecordDeleted()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordDeleted copyWith(void Function(RecordDeleted) updates) => super.copyWith((message) => updates(message as RecordDeleted)) as RecordDeleted;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordDeleted create() => RecordDeleted._();
  RecordDeleted createEmptyInstance() => create();
  static $pb.PbList<RecordDeleted> createRepeated() => $pb.PbList<RecordDeleted>();
  @$core.pragma('dart2js:noInline')
  static RecordDeleted getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordDeleted>(create);
  static RecordDeleted? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$fixnum.Int64> get ids => $_getList(0);
}

enum Message_Message {
  welcome, 
  recordUpdated, 
  recordDeleted, 
  notSet
}

class Message extends $pb.GeneratedMessage {
  factory Message() => create();
  Message._() : super();
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Message_Message> _Message_MessageByTag = {
    100 : Message_Message.welcome,
    101 : Message_Message.recordUpdated,
    102 : Message_Message.recordDeleted,
    0 : Message_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Message', package: const $pb.PackageName(_omitMessageNames ? '' : 'message'), createEmptyInstance: create)
    ..oo(0, [100, 101, 102])
    ..aInt64(1, _omitFieldNames ? '' : 'timestamp')
    ..aOM<Welcome>(100, _omitFieldNames ? '' : 'welcome', subBuilder: Welcome.create)
    ..aOM<RecordUpdated>(101, _omitFieldNames ? '' : 'recordUpdated', protoName: 'recordUpdated', subBuilder: RecordUpdated.create)
    ..aOM<RecordDeleted>(102, _omitFieldNames ? '' : 'recordDeleted', protoName: 'recordDeleted', subBuilder: RecordDeleted.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  Message_Message whichMessage() => _Message_MessageByTag[$_whichOneof(0)]!;
  void clearMessage() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get timestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set timestamp($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);

  @$pb.TagNumber(100)
  Welcome get welcome => $_getN(1);
  @$pb.TagNumber(100)
  set welcome(Welcome v) { setField(100, v); }
  @$pb.TagNumber(100)
  $core.bool hasWelcome() => $_has(1);
  @$pb.TagNumber(100)
  void clearWelcome() => clearField(100);
  @$pb.TagNumber(100)
  Welcome ensureWelcome() => $_ensure(1);

  @$pb.TagNumber(101)
  RecordUpdated get recordUpdated => $_getN(2);
  @$pb.TagNumber(101)
  set recordUpdated(RecordUpdated v) { setField(101, v); }
  @$pb.TagNumber(101)
  $core.bool hasRecordUpdated() => $_has(2);
  @$pb.TagNumber(101)
  void clearRecordUpdated() => clearField(101);
  @$pb.TagNumber(101)
  RecordUpdated ensureRecordUpdated() => $_ensure(2);

  @$pb.TagNumber(102)
  RecordDeleted get recordDeleted => $_getN(3);
  @$pb.TagNumber(102)
  set recordDeleted(RecordDeleted v) { setField(102, v); }
  @$pb.TagNumber(102)
  $core.bool hasRecordDeleted() => $_has(3);
  @$pb.TagNumber(102)
  void clearRecordDeleted() => clearField(102);
  @$pb.TagNumber(102)
  RecordDeleted ensureRecordDeleted() => $_ensure(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
