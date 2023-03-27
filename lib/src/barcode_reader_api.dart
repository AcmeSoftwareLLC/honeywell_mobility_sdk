// Copyright 2023 Acme Software LLC. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v9.1.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class BarcodeReadEvent {
  BarcodeReadEvent({
    required this.barcodeData,
    required this.charset,
    required this.codeId,
    required this.aimId,
    required this.timestamp,
  });

  String barcodeData;

  String charset;

  String codeId;

  String aimId;

  String timestamp;

  Object encode() {
    return <Object?>[
      barcodeData,
      charset,
      codeId,
      aimId,
      timestamp,
    ];
  }

  static BarcodeReadEvent decode(Object result) {
    result as List<Object?>;
    return BarcodeReadEvent(
      barcodeData: result[0]! as String,
      charset: result[1]! as String,
      codeId: result[2]! as String,
      aimId: result[3]! as String,
      timestamp: result[4]! as String,
    );
  }
}

class BarcodeFailureEvent {
  BarcodeFailureEvent({
    required this.timestamp,
  });

  String timestamp;

  Object encode() {
    return <Object?>[
      timestamp,
    ];
  }

  static BarcodeFailureEvent decode(Object result) {
    result as List<Object?>;
    return BarcodeFailureEvent(
      timestamp: result[0]! as String,
    );
  }
}

class _BarcodeReaderApiCodec extends StandardMessageCodec {
  const _BarcodeReaderApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is BarcodeFailureEvent) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is BarcodeReadEvent) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return BarcodeFailureEvent.decode(readValue(buffer)!);
      case 129: 
        return BarcodeReadEvent.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class BarcodeReaderApi {
  /// Constructor for [BarcodeReaderApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  BarcodeReaderApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _BarcodeReaderApiCodec();

  /// {@template honeywell.reader.aim}
  /// Sets the aiming state of the scanner.
  /// {@endtemplate}
  Future<void> aim(bool arg_on) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.aim', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_on]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// {@template honeywell.reader.claim}
  /// Claims the scanner.
  ///
  /// Client activities should call this method in onResume() to ensure that
  /// the scanner is claimed before making any calls to control the scanner.
  ///
  /// Calls to control the scanner such as [decode]
  /// will throw [PlatformException] if claim() has not been called.
  ///
  /// Once claimed, the scanner will begin to post events to registered event listeners.
  /// {@endtemplate}
  Future<void> claim() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.claim', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// {@template honeywell.reader.close}
  /// Closes the scanner and terminates the established session.
  ///
  /// Once close() has been called, any future calls on this object will throw.
  /// Client activities should call this method in onClose()
  /// to terminate the scanner session prior to exiting.
  /// {@endtemplate}
  Future<void> close() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.close', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// {@template honeywell.reader.create}
  /// Creates a new BarcodeReader object.
  /// {@endtemplate}
  Future<bool> create() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.create', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  /// {@template honeywell.reader.decode}
  /// Sets the decoding state of the scanner.
  /// {@endtemplate}
  Future<void> decode(bool arg_on) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.decode', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_on]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// {@template honeywell.reader.light}
  /// Sets the aiming state of the scanner.
  /// {@endtemplate}
  Future<void> light(bool arg_on) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.light', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_on]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// {@template honeywell.reader.notify}
  /// Use the BarcodeReader's built-in mechanism for notifying the user of events.
  /// {@endtemplate}
  Future<void> notify(String arg_notification) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.notify', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_notification]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// {@template honeywell.reader.release}
  /// Releases the scanner claim.
  ///
  /// Client activities should call this method in onPause()
  /// to stop receiving scan notifications while the activity is inactive.
  /// {@endtemplate}
  Future<void> release() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.release', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// {@template honeywell.reader.setProperties}
  /// Sets a map of properties.
  /// {@endtemplate}
  Future<void> setProperties(Map<String?, Object?> arg_properties) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.setProperties', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_properties]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// {@template honeywell.reader.softwareTrigger}
  /// Sends a trigger up/down action
  ///
  /// [state] - whether to trigger the scanner on or off
  /// {@endtemplate}
  Future<void> softwareTrigger(bool arg_state) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BarcodeReaderApi.softwareTrigger', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_state]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}

class _BarcodeReaderFlutterApiCodec extends StandardMessageCodec {
  const _BarcodeReaderFlutterApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is BarcodeFailureEvent) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is BarcodeReadEvent) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return BarcodeFailureEvent.decode(readValue(buffer)!);
      case 129: 
        return BarcodeReadEvent.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class BarcodeReaderFlutterApi {
  static const MessageCodec<Object?> codec = _BarcodeReaderFlutterApiCodec();

  void onBarcodeEvent(BarcodeReadEvent event);

  void onFailureEvent(BarcodeFailureEvent event);

  static void setup(BarcodeReaderFlutterApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.BarcodeReaderFlutterApi.onBarcodeEvent', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.BarcodeReaderFlutterApi.onBarcodeEvent was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final BarcodeReadEvent? arg_event = (args[0] as BarcodeReadEvent?);
          assert(arg_event != null,
              'Argument for dev.flutter.pigeon.BarcodeReaderFlutterApi.onBarcodeEvent was null, expected non-null BarcodeReadEvent.');
          api.onBarcodeEvent(arg_event!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.BarcodeReaderFlutterApi.onFailureEvent', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.BarcodeReaderFlutterApi.onFailureEvent was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final BarcodeFailureEvent? arg_event = (args[0] as BarcodeFailureEvent?);
          assert(arg_event != null,
              'Argument for dev.flutter.pigeon.BarcodeReaderFlutterApi.onFailureEvent was null, expected non-null BarcodeFailureEvent.');
          api.onFailureEvent(arg_event!);
          return;
        });
      }
    }
  }
}
