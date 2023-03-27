import 'package:honeywell_mobility_sdk/src/barcode_reader.dart';
import 'package:honeywell_mobility_sdk/src/barcode_reader_api.dart';

export 'src/barcode_reader.dart';

class HoneywellMobilitySdk {
  static Future<BarcodeReader?> createBarcodeReader({
    required BarcodeEventCallback<BarcodeReadEvent> onRead,
    required BarcodeEventCallback<BarcodeFailureEvent> onFailure,
  }) async {
    final api = BarcodeReaderApi();
    final isSupported = await api.create();

    if (!isSupported) return null;

    return BarcodeReader(api: api, onRead: onRead, onFailure: onFailure);
  }
}
