import 'package:honeywell_mobility_sdk/src/barcode_reader.dart';

/// Defines the properties that can be set on a [BarcodeReader].
class BarcodeReaderProperty<T extends Object> {
  /// Creates a new [BarcodeReaderProperty] instance.
  const BarcodeReaderProperty(this.key);

  /// The key of the property.
  final String key;

  /// Creates a new [BarcodeReaderPropertyEntry] instance paired with [key].
  BarcodeReaderPropertyEntry<T> call(T value) {
    return BarcodeReaderPropertyEntry(key, value);
  }

  /// Properties related to imager.
  static const BarcodeReaderImagerPropertyGroup imager =
      BarcodeReaderImagerPropertyGroup();

  /// Properties related to notification.
  static const BarcodeReaderNotificationPropertyGroup notification =
      BarcodeReaderNotificationPropertyGroup();

  /// Properties related to trigger.
  static const BarcodeReaderTriggerPropertyGroup trigger =
      BarcodeReaderTriggerPropertyGroup();

  /// Properties related to symbology.
  static const BarcodeReaderSymbologyPropertyGroup symbology =
      BarcodeReaderSymbologyPropertyGroup();

  /// Properties related to data processing.
  static const BarcodeReaderDataProcessingPropertyGroup dataProcessing =
      BarcodeReaderDataProcessingPropertyGroup();
}

/// Defines a property entry that can be set on a [BarcodeReader].
class BarcodeReaderPropertyEntry<T extends Object> {
  /// Creates a new [BarcodeReaderPropertyEntry] instance.
  const BarcodeReaderPropertyEntry(this.key, this._value);

  /// The key of the property.
  final String key;
  final T _value;

  /// The value of the property.
  Object get value {
    final value = _value;
    return value is Enum ? value.name : value;
  }

  @override
  String toString() => 'BarcodeReaderPropertyEntry($key, $value)';
}

/// Defines the properties that can be set on a [BarcodeReader]
/// related to imager.
class BarcodeReaderImagerPropertyGroup {
  /// Creates a new [BarcodeReaderImagerPropertyGroup] instance.
  const BarcodeReaderImagerPropertyGroup();

  /// Maximum exposure time in microseconds when using automatic exposure.
  BarcodeReaderProperty<int> get lightIntensity =>
      const BarcodeReaderProperty('IMG_ILLUM_INTENSITY');

  /// Imager exposure.
  /// Exposure time (in microseconds) when using fixed exposure.
  BarcodeReaderProperty<int> get exposure =>
      const BarcodeReaderProperty('IMG_EXPOSURE');

  /// Sensitivity of image sensor when using fixed exposure.
  BarcodeReaderProperty<int> get gain =>
      const BarcodeReaderProperty('IMG_GAIN');

  /// Maximum exposure time in microseconds when using automatic exposure.
  BarcodeReaderProperty<int> get maximumExposure =>
      const BarcodeReaderProperty('IMG_MAX_EXPOSURE');

  /// Maximum sensitivity of image sensor when using automatic exposure.
  BarcodeReaderProperty<int> get maximumGain =>
      const BarcodeReaderProperty('IMG_MAX_GAIN');

  /// Target calculated value of image during automated exposure control.
  BarcodeReaderProperty<int> get targetValue =>
      const BarcodeReaderProperty('IMG_TARGET_VALUE');

  /// Acceptable difference from [targetValue] of images.
  BarcodeReaderProperty<int> get targetAcceptableOffset =>
      const BarcodeReaderProperty('IMG_TARGET_ACCEPTABLE_OFFSET');

  /// Maximum number of images to reject
  /// because the aren't close enough to [targetValue].
  BarcodeReaderProperty<int> get rejectionLimit =>
      const BarcodeReaderProperty('IMG_REJECTION_LIMIT');

  /// Target percentile of target value for the Automatic Exposure mode.
  BarcodeReaderProperty<int> get targetPercentile =>
      const BarcodeReaderProperty('IMG_TARGET_PERCENTILE');

  /// If and how exposure is automatically updated to improve image quality.
  BarcodeReaderProperty<ImageExposureMode> get exposureMode =>
      const BarcodeReaderProperty('IMG_EXPOSURE_MODE');

  /// How image quality is determined by software controlled exposure modes.
  BarcodeReaderProperty<ImageSampleMethod> get sampleMode =>
      const BarcodeReaderProperty('IMG_SAMPLE_METHOD');
}

/// Defines the properties that can be set on a [BarcodeReader]
/// related to notifications.
class BarcodeReaderNotificationPropertyGroup {
  /// Creates a new [BarcodeReaderNotificationPropertyGroup] instance.
  const BarcodeReaderNotificationPropertyGroup();

  /// Good Read Notification Enable/Disable.
  ///
  /// This setting determines whether the Good Read Beep
  /// and LED will play on successful decode.
  BarcodeReaderProperty<bool> get goodReadEnabled =>
      const BarcodeReaderProperty('NTF_GOOD_READ_ENABLED');

  /// Bad Read Notification Enable/Disable.
  ///
  /// This setting determines whether the Bad Read Beep
  /// and LED will play when no bar code is decoded.
  BarcodeReaderProperty<bool> get badReadEnabled =>
      const BarcodeReaderProperty('NTF_BAD_READ_ENABLED');

  /// Vibration Enable/Disabled.
  ///
  /// This setting determines whether the device will vibrate
  /// when a notification occurs.
  /// Note that this setting is ignored,
  /// if the device's ringer mode is set to SILENT.
  BarcodeReaderProperty<bool> get vibrateEnabled =>
      const BarcodeReaderProperty('NTF_VIBRATE_ENABLED');
}

/// Defines the properties that can be set on a [BarcodeReader]
/// related to trigger.
class BarcodeReaderTriggerPropertyGroup {
  /// Creates a new [BarcodeReaderTriggerPropertyGroup] instance.
  const BarcodeReaderTriggerPropertyGroup();

  /// Trigger control mode.
  ///
  /// This setting determines what the behavior will be
  /// when the scan trigger state changes.
  BarcodeReaderProperty<TriggerControlMode> get controlMode =>
      const BarcodeReaderProperty('TRIG_CONTROL_MODE');

  /// Automatic trigger mode timeout.
  ///
  /// This setting only applies when [controlMode]
  /// is set to [TriggerControlMode.autoControl].
  ///
  /// The value is an integer (in seconds) indicating
  /// how long the scanner will remain on while the scan trigger is pressed.
  /// Once this timeout has expired,
  /// the scanner will automatically be turned off to save power.
  BarcodeReaderProperty<int> get autoModeTimeout =>
      const BarcodeReaderProperty('TRIG_AUTO_MODE_TIMEOUT');

  /// Trigger enable.
  BarcodeReaderProperty<bool> get enable =>
      const BarcodeReaderProperty('TRIG_ENABLE');

  /// Trigger scan delay.
  ///
  /// This setting turns on the aimer for a duration before starting to scan
  /// (in milliseconds).
  BarcodeReaderProperty<int> get scanDelay =>
      const BarcodeReaderProperty('TRIG_SCAN_DELAY');

  /// Trigger scan mode.
  ///
  /// This setting determines what the behavior will be
  /// when the trigger is pressed.
  BarcodeReaderProperty<TriggerScanMode> get scanMode =>
      const BarcodeReaderProperty('TRIG_SCAN_MODE');
}

/// Defines the properties that can be set on a [BarcodeReader]
/// related to symbology.
class BarcodeReaderSymbologyPropertyGroup {
  /// Creates a new [BarcodeReaderSymbologyPropertyGroup] instance.
  const BarcodeReaderSymbologyPropertyGroup();

  /// Enable or disable Code 128 FNC4.
  BarcodeReaderProperty<bool> get code128FNC4 =>
      const BarcodeReaderProperty('DEC_C128_FNC4_ENABLED');

  /// Enable or disable Code 128 FNC4.
  BarcodeReaderProperty<bool> get code128 =>
      const BarcodeReaderProperty('DEC_CODE128_ENABLED');

  /// Enable or disable GS1 128.
  BarcodeReaderProperty<bool> get gs1128 =>
      const BarcodeReaderProperty('DEC_GS1_128_ENABLED');

  /// Enable or disable ISBT 128.
  BarcodeReaderProperty<bool> get isbt128 =>
      const BarcodeReaderProperty('DEC_C128_ISBT_ENABLED');

  /// Enable or disable Code 39.
  BarcodeReaderProperty<bool> get code39 =>
      const BarcodeReaderProperty('DEC_CODE39_ENABLED');

  /// Enable or disable full ASCII.
  /// When Code 39 full ASCII conversion is enabled Code 39 bar codes
  /// are transmitted with an extended character set.
  ///
  /// The full 128 ASCII character set is encoded in Code 39
  /// by combining two regular Code 39 characters.
  BarcodeReaderProperty<bool> get code39FullAscii =>
      const BarcodeReaderProperty('DEC_CODE39_FULL_ASCII_ENABLED');

  /// Enable or disable the start/stop transmission for Code 39.
  BarcodeReaderProperty<bool> get code39StartStopTransmit =>
      const BarcodeReaderProperty('DEC_CODE39_START_STOP_TRANSMIT');

  /// Enable or disable Base 32 Conversion for Code 39.
  BarcodeReaderProperty<bool> get code39BAse32 =>
      const BarcodeReaderProperty('DEC_CODE39_BASE32_ENABLED');

  /// Enable or disable Datamatrix.
  BarcodeReaderProperty<bool> get dataMatrix =>
      const BarcodeReaderProperty('DEC_DATAMATRIX_ENABLED');

  /// Enable or disable Grid Matrix.
  BarcodeReaderProperty<bool> get gridMatrix =>
      const BarcodeReaderProperty('DEC_GRIDMATRIX_ENABLED');

  /// Enable or disable UPC-A.
  BarcodeReaderProperty<bool> get upca =>
      const BarcodeReaderProperty('DEC_UPCA_ENABLE');

  /// Enable or disable UPC-E0.
  BarcodeReaderProperty<bool> get upce =>
      const BarcodeReaderProperty('DEC_UPCE0_ENABLED');

  /// Enable or disable Aztec.
  BarcodeReaderProperty<bool> get aztec =>
      const BarcodeReaderProperty('DEC_AZTEC_ENABLED');

  /// Enable or disable Codabar.
  BarcodeReaderProperty<bool> get codebar =>
      const BarcodeReaderProperty('DEC_CODABAR_ENABLED');

  /// Enable or disable Code 93.
  BarcodeReaderProperty<bool> get code93 =>
      const BarcodeReaderProperty('DEC_CODE93_ENABLED');

  /// Enable or disable EAN-8.
  BarcodeReaderProperty<bool> get ean8 =>
      const BarcodeReaderProperty('DEC_EAN8_ENABLED');

  /// Enable or disable EAN-13.
  BarcodeReaderProperty<bool> get ean13 =>
      const BarcodeReaderProperty('DEC_EAN13_ENABLED');

  /// Enable or disable Maxicode.
  BarcodeReaderProperty<bool> get maxiCode =>
      const BarcodeReaderProperty('DEC_MAXICODE_ENABLED');

  /// Enable or disable PDF-417.
  BarcodeReaderProperty<bool> get pdf417 =>
      const BarcodeReaderProperty('DEC_PDF417_ENABLED');

  /// Enable or disable QR Code.
  BarcodeReaderProperty<bool> get qrCode =>
      const BarcodeReaderProperty('DEC_QR_ENABLED');

  /// Enable or disable GS1 DataBar Omnidirectional.
  BarcodeReaderProperty<bool> get rss =>
      const BarcodeReaderProperty('DEC_RSS_14_ENABLED');

  /// Enable or disable GS1 DataBar Limited.
  BarcodeReaderProperty<bool> get rssLimited =>
      const BarcodeReaderProperty('DEC_RSS_LIMITED_ENABLED');

  /// Enable or disable GS1 DataBar Expanded.
  BarcodeReaderProperty<bool> get rssExpanded =>
      const BarcodeReaderProperty('DEC_RSS_EXPANDED_ENABLED');

  /// Enable or disable Interleaved 2 of 5.
  BarcodeReaderProperty<bool> get interleaved25 =>
      const BarcodeReaderProperty('DEC_I25_ENABLED');
}

/// Defines the properties that can be set on a [BarcodeReader]
/// related to data processing.
class BarcodeReaderDataProcessingPropertyGroup {
  /// Creates a new [BarcodeReaderDataProcessingPropertyGroup] instance.
  const BarcodeReaderDataProcessingPropertyGroup();

  /// Data added to the beginning of the bar code data.
  BarcodeReaderProperty<String> get prefix =>
      const BarcodeReaderProperty('DPR_PREFIX');

  /// Data added to the end of the bar code data.
  BarcodeReaderProperty<String> get suffix =>
      const BarcodeReaderProperty('DPR_SUFFIX');

  /// Data added to the beginning of the bar code data to indicate the symbology
  BarcodeReaderProperty<String> get symbologyPrefix =>
      const BarcodeReaderProperty('DPR_SYMBOLOGY_PREFIX');

  /// Indicates if scanning bar codes containing URLs
  /// will open the internet browser.
  BarcodeReaderProperty<bool> get launchBrowser =>
      const BarcodeReaderProperty('DPR_LAUNCH_BROWSER');

  /// Indicates if scanning bar codes generated by EZ Config for Mobility
  /// will launch EZ Config on the mobile computer to apply settings.
  BarcodeReaderProperty<bool> get ezConfig =>
      const BarcodeReaderProperty('DPR_LAUNCH_EZ_CONFIG');

  /// Indicates if bar codes starting with "//" will attempt to open an application.
  BarcodeReaderProperty<bool> get scanToIntent =>
      const BarcodeReaderProperty('DPR_SCAN_TO_INTENT');
}

/// If and how exposure is automatically updated to improve image quality.
enum ImageExposureMode {
  /// Exposure does not change automatically.
  fixed,

  /// Image sensor controls the exposure automatically.
  autoSensor,

  /// Software automatically updates exposure to improve image quality.
  autoExposure,

  /// Software automatically updates exposure
  /// to improve image quality of bar codes.
  contextSensitive,
}

/// How image quality is determined by software controlled exposure modes.
enum ImageSampleMethod {
  /// Image quality determined by entire image.
  uniform,

  /// Image quality determined by center of image.
  center,

  /// Image quality determined by entire image
  /// but weighted toward center of image.
  centerWeighted,
}

/// Determines what the behavior will be when the scan trigger state changes.
enum TriggerControlMode {
  /// Disabled.
  /// When this setting is applied, pressing the scan button will not be handled
  disable,

  /// Automatic control.
  /// When this setting is applied,
  /// the scanner service will handle the scan trigger state changes,
  /// turning the scanner on when pressed, and turning it off when released.
  ///
  /// Turning the scanner on means turning on the aimer and illumination,
  /// and enabling decoding.
  autoControl,

  /// Client control.
  /// When this setting is applied,
  /// the scanner service will notify registered client(s)
  /// when the scan trigger state changes.
  ///
  /// It is then up to the client to decide how to handle these trigger events.
  clientControl,
}

/// Determines what the behavior will be when the trigger is pressed.
enum TriggerScanMode {
  /// OneShot.
  /// When this setting is applied,
  /// pressing the trigger button will allow to scan only one barcode.
  oneShot,

  /// Continuous.
  /// When this setting is applied,
  /// pressing the trigger button will allow to scan multiple barcodes,
  /// however duplicate barcodes are not scanned.
  continuous,

  /// ReadOnRelease.
  /// When this setting is applied, pressing the trigger will start the aimer
  /// and releasing the trigger will scan the barcode.
  readOnRelease,

  /// ReadOnSecondTriggerPress.
  /// When this setting is applied,
  /// pressing the trigger first time will start the aimer
  /// and pressing the trigger second time will scan the barcode.
  readOnSecondTriggerPress,
}
