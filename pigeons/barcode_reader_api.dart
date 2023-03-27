import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/barcode_reader_api.dart',
    kotlinOut:
        'android/src/main/kotlin/com/acmesoftware/honeywell_mobility_sdk/api/BarcodeReaderApi.kt',
    kotlinOptions: KotlinOptions(
      package: 'com.acmesoftware.honeywell_mobility_sdk',
    ),
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
class TestMessage {
  TestMessage(this.message);
  String message;
}

@HostApi()
abstract class BarcodeReaderApi {
  /// {@template honeywell.reader.aim}
  /// Sets the aiming state of the scanner.
  /// {@endtemplate}
  void aim(bool on);

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
  void claim();

  /// {@template honeywell.reader.close}
  /// Closes the scanner and terminates the established session.
  ///
  /// Once close() has been called, any future calls on this object will throw.
  /// Client activities should call this method in onClose()
  /// to terminate the scanner session prior to exiting.
  /// {@endtemplate}
  void close();

  /// {@template honeywell.reader.create}
  /// Creates a new BarcodeReader object.
  /// {@endtemplate}
  bool create();

  /// {@template honeywell.reader.decode}
  /// Sets the decoding state of the scanner.
  /// {@endtemplate}
  void decode(bool on);

  /// {@template honeywell.reader.light}
  /// Sets the aiming state of the scanner.
  /// {@endtemplate}
  void light(bool on);

  /// {@template honeywell.reader.notify}
  /// Use the BarcodeReader's built-in mechanism for notifying the user of events.
  /// {@endtemplate}
  void notify(String notification);

  /// {@template honeywell.reader.release}
  /// Releases the scanner claim.
  ///
  /// Client activities should call this method in onPause()
  /// to stop receiving scan notifications while the activity is inactive.
  /// {@endtemplate}
  void release();

  /// {@template honeywell.reader.setProperties}
  /// Sets a map of properties.
  /// {@endtemplate}
  void setProperties(Map<String, Object> properties);

  /// {@template honeywell.reader.softwareTrigger}
  /// Sends a trigger up/down action
  ///
  /// [state] - whether to trigger the scanner on or off
  /// {@endtemplate}
  void softwareTrigger(bool state);
}

@FlutterApi()
abstract class BarcodeReaderFlutterApi {
  void onBarcodeEvent(BarcodeReadEvent event);

  void onFailureEvent(BarcodeFailureEvent event);
}

class BarcodeReadEvent {
  BarcodeReadEvent({
    required this.barcodeData,
    required this.charset,
    required this.codeId,
    required this.aimId,
    required this.timestamp,
  });

  final String barcodeData;
  final String charset;
  final String codeId;
  final String aimId;
  final String timestamp;
}

class BarcodeFailureEvent {
  BarcodeFailureEvent({required this.timestamp});

  final String timestamp;
}