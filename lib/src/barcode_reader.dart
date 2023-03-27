import 'package:flutter/foundation.dart';
import 'package:honeywell_mobility_sdk/src/barcode_reader_api.dart';
import 'package:honeywell_mobility_sdk/src/barcode_reader_property.dart';

typedef BarcodeEventCallback<T> = void Function(T event);

class BarcodeReader implements BarcodeReaderFlutterApi {
  BarcodeReader({
    required BarcodeReaderApi api,
    required BarcodeEventCallback<BarcodeReadEvent> onRead,
    required BarcodeEventCallback<BarcodeFailureEvent> onFailure,
  })  : _api = api,
        _onRead = onRead,
        _onFailure = onFailure;

  final BarcodeReaderApi _api;
  final BarcodeEventCallback<BarcodeReadEvent> _onRead;
  final BarcodeEventCallback<BarcodeFailureEvent> _onFailure;

  /// {@macro honeywell.reader.aim}
  Future<void> aim(bool on) => _api.aim(on);

  /// {@macro honeywell.reader.claim}
  Future<void> claim() => _api.claim();

  /// {@macro honeywell.reader.close}
  Future<void> close() => _api.close();

  /// {@macro honeywell.reader.decode}
  Future<void> decode(bool on) => _api.decode(on);

  /// {@macro honeywell.reader.light}
  Future<void> light(bool on) => _api.light(on);

  /// {@macro honeywell.reader.notify}
  Future<void> notify(BarcodeReaderNotification notification) {
    return _api.notify(notification.name);
  }

  /// {@macro honeywell.reader.release}
  Future<void> release() => _api.release();

  /// {@macro honeywell.reader.setProperties}
  Future<void> setProperties(Set<MapEntry<String, Object>> properties) {
    return _api.setProperties(Map.fromEntries(properties));
  }

  /// {@macro honeywell.reader.softwareTrigger}
  Future<void> softwareTrigger(bool state) => _api.softwareTrigger(state);

  @override
  @protected
  void onBarcodeEvent(BarcodeReadEvent event) => _onRead(event);

  @override
  @protected
  void onFailureEvent(BarcodeFailureEvent event) => _onFailure(event);
}

enum BarcodeReaderNotification {
  good('goodRead'),
  bad('badRead');

  const BarcodeReaderNotification(this.name);

  final String name;
}

final Map<String, String> _codeTypes = {
  'A': 'Australian Post',
  'B': 'British Post',
  'C': 'Canadian Post',
  'D': 'EAN-8',
  'E': 'UPC-E',
  'H': 'Chinese Sensible Code (Han Xin Code)',
  'J': 'Japanese Post',
  'K': 'KIX (Netherlands) Post',
  'L': 'Planet Code',
  'M': 'Intelligent Mail Bar Code',
  'N': 'Postal-4i',
  'P': 'Postnet',
  'Q': 'China Post (Hong Kong 2 of 5)',
  'R': 'MicroPDF417',
  'T': 'TCIF Linked code 39 (TLC39)',
  'V': 'Codablock A',
  'Y': 'NEC 2 of 5',
  'a': 'Codabar',
  'b': 'Code 39',
  'c': 'UPC-A',
  'd': 'EAN-13 / Bookland EAN',
  'e': 'Interleaved 2 of 5',
  'f': 'Straight 2 Of 5 IATA / Industrial',
  'g': 'MSI',
  'h': 'Code 11',
  'i': 'Code 93 and 93i',
  'j': 'Code 128',
  'l': 'Code 49',
  'm': 'Matrix 2 of 5',
  'q': 'Codablock F',
  'r': 'PDF417',
  's': 'QR Code or Micro QR Code',
  't': 'Telepen',
  'w': 'Data Matrix',
  'x': 'MaxiCode',
  'y': 'GS1 (Composite / DataBar / DataBar Omnidirectional)',
  'z': 'Aztec',
  '{': 'GS1 DataBar Limited',
  '|': 'GS1-128',
  '}': 'GS1 DataBar Expanded',
  '<': 'Code 32 Pharmaceutical (PARAF)',
  ',': 'InfoMail',
  '?': 'Korea Post',
};

extension BarcodeReaderExtension on BarcodeReadEvent {
  String get codeType => _codeTypes[codeId] ?? 'Unknown';
}
