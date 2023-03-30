import 'package:honeywell_mobility_sdk/src/barcode_reader.dart';
import 'package:honeywell_mobility_sdk/src/barcode_reader_api.dart';
import 'package:honeywell_mobility_sdk/src/barcode_reader_property.dart';

export 'src/barcode_reader.dart';
export 'src/barcode_reader_property.dart';

/// Honeywell Mobility SDK for Flutter.
abstract class HoneywellMobilitySdk {
  /// This attempts to instantiate a [BarcodeReader].
  /// If an error occurs, an exception describing the error will be thrown.
  ///
  /// The returned BarcodeReader object represents a session associated
  /// with the internal scanner in case of handheld devices
  /// or external scanner connected on COM1 port in case of VM1A.
  static Future<BarcodeReader?> createBarcodeReader({
    required BarcodeEventCallback<BarcodeReadEvent> onRead,
    required BarcodeEventCallback<BarcodeFailureEvent> onFailure,
    BarcodeEventCallback<TriggerStateChangeEvent>? onTrigger,
    bool defaultProperties = true,
  }) async {
    final api = BarcodeReaderApi();
    final isSupported = await api.create();

    if (!isSupported) return null;

    final reader = BarcodeReader(
      api: api,
      onRead: onRead,
      onFailure: onFailure,
      onTrigger: onTrigger,
    );

    if (defaultProperties) {
      await reader.setProperties({
        BarcodeReaderProperty.trigger.controlMode(
          TriggerControlMode.autoControl,
        ),
        BarcodeReaderProperty.dataProcessing.launchBrowser(false),
        BarcodeReaderProperty.symbology.aztec(true),
        BarcodeReaderProperty.symbology.codebar(true),
        BarcodeReaderProperty.symbology.code39(true),
        BarcodeReaderProperty.symbology.code93(true),
        BarcodeReaderProperty.symbology.code128(true),
        BarcodeReaderProperty.symbology.dataMatrix(true),
        BarcodeReaderProperty.symbology.ean8(true),
        BarcodeReaderProperty.symbology.ean13(true),
        BarcodeReaderProperty.symbology.maxiCode(true),
        BarcodeReaderProperty.symbology.pdf417(true),
        BarcodeReaderProperty.symbology.qrCode(true),
        BarcodeReaderProperty.symbology.rss(true),
        BarcodeReaderProperty.symbology.rssExpanded(true),
        BarcodeReaderProperty.symbology.upca(true),
        BarcodeReaderProperty.symbology.upce(true),
      });
    }

    return reader;
  }
}
