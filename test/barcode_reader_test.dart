import 'package:flutter_test/flutter_test.dart';
import 'package:honeywell_mobility_sdk/honeywell_mobility_sdk.dart';
import 'package:honeywell_mobility_sdk/src/barcode_reader_api.dart';

import 'barcode_reader_api.g.dart';

class _ApiLogger implements TestBarcodeReaderApi {
  final List<String> logs = [];
  Map<String, Object> properties = {};

  @override
  void aim(bool on) {
    logs.add('aim($on)');
  }

  @override
  void claim() {
    logs.add('claim()');
  }

  @override
  void close() {
    logs.add('close()');
  }

  @override
  bool create() {
    logs.add('create()');
    return true;
  }

  @override
  void decode(bool on) {
    logs.add('decode($on)');
  }

  @override
  void light(bool on) {
    logs.add('light($on)');
  }

  @override
  void notify(String notification) {
    logs.add('notify($notification)');
  }

  @override
  void release() {
    logs.add('release()');
  }

  @override
  void setProperties(Map<String?, Object?> properties) {
    logs.add('setProperties');
    this.properties = properties.cast();
  }

  @override
  void softwareTrigger(bool state) {
    logs.add('softwareTrigger($state)');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BarcodeReader tests |', () {
    final BarcodeReader reader = BarcodeReader(
      api: BarcodeReaderApi(),
      onRead: (_) {},
      onFailure: (_) {},
    );
    late final _ApiLogger logger;

    setUp(() {
      logger = _ApiLogger();
      TestBarcodeReaderApi.setup(logger);
    });

    test('claim', () async {
      await reader.claim();
      expect(
        logger.logs.last,
        'claim()',
      );
    });

    test('setProperties', () async {
      await reader.setProperties(
        {
          BarcodeReaderProperty.symbology.aztec(true),
          BarcodeReaderProperty.symbology.ean8(false),
        },
      );
      expect(logger.logs.last, 'setProperties');
      expect(
        logger.properties,
        {
          'DEC_AZTEC_ENABLED': true,
          'DEC_EAN8_ENABLED': false,
        },
      );
    });
  });
}
